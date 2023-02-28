//
//  EmojisMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 01/12/2022.
//

import Foundation
import Combine

class EmojisMemoryGameViewModel: MemoryGame, ObservableObject {
	
	var cancellables = Set<AnyCancellable>()
	
	typealias Content = String
	
	@Published var timerText: String
	@Published var cards: [Card<String>]
	@Published var gameOverStatus: GameOverStatus = .notStarted
	
	@Published var time = 0
	
	private var timer: Timer?
	private var indexOfCurrentFaceUpCard: Int?
	private var formatter: DateComponentsFormatter {
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.minute, .second]
		formatter.unitsStyle = .positional
		formatter.zeroFormattingBehavior = [.pad]
		return formatter
	}
	
	private var cancelables = Set<AnyCancellable>()
	
	init(emojis: [String]) {
		self.cards = emojis
			.enumerated()
			.flatMap { (index, element) in
				return [
					Card.init(id: index * 2		, match_id: index, item: element),
					Card.init(id: index * 2 + 1 , match_id: index, item: element)
				]
			}
			.shuffled()
		
		timerText = ""
		
		$time
			.sink { [weak self] time in
				guard let self else { return }
				self.timerText = "Time: \(self.formatter.string(from: TimeInterval(time)) ?? "")"
			}
			.store(in: &cancelables)
		
		$gameOverStatus
			.filter { $0 == .middle }
			.first()
			.eraseToAnyPublisher()
			.sink { [weak self] status in
				self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
					self?.time += 1
				}
			}
			.store(in: &cancelables)
		
		$gameOverStatus
			.filter { $0 == .end }
			.eraseToAnyPublisher()
			.sink { [weak self] status in
				self?.timer?.invalidate()
			}
			.store(in: &cancelables)
	}
	
	deinit {
		timer?.invalidate()
	}
	
	func choose(card: Card<String>) {
		guard
			let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
			let chosenCard = cards[safe: chosenIndex],
			!chosenCard.isMatched
		else { return }
		gameOverStatus = .middle
		if let potentialMatchIndex = indexOfCurrentFaceUpCard {
			if cards[chosenIndex].id != cards[potentialMatchIndex].id {
				cards[chosenIndex].isFaceUp.toggle()
				if cards[chosenIndex].match_id == cards[potentialMatchIndex].match_id {
					cards[safe: chosenIndex]?.isMatched = true
					cards[safe: potentialMatchIndex]?.isMatched = true
				}
				indexOfCurrentFaceUpCard = nil
			}
		} else {
			for index in cards.indices {
				cards[safe: index]?.isFaceUp = false
			}
			indexOfCurrentFaceUpCard = chosenIndex
			cards[chosenIndex].isFaceUp.toggle()
		}
		if cards.allSatisfy({ $0.isMatched == true }) {
			gameOverStatus = .end
			self.sendScore()
				.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
				.store(in: &cancellables)
		}
	}
}
