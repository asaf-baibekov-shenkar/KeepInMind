//
//  EmojisMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 01/12/2022.
//

import Foundation

class EmojisMemoryGameViewModel: MemoryGame, ObservableObject {
	typealias Content = String
	
	@Published var cards: [Card<String>]
	
	private var indexOfCurrentFaceUpCard: Int?
	
	init() {
		self.cards = ["🥶", "😎", "🤬", "👻", "😈", "🤢"]
			.enumerated()
			.flatMap { (index, element) in
				return [
					Card.init(id: index * 2		, match_id: index, item: element),
					Card.init(id: index * 2 + 1 , match_id: index, item: element)
				]
			}
			.shuffled()
	}
	
	func choose(card: Card<String>) {
		guard
			let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
			let chosenCard = cards[safe: chosenIndex],
			!chosenCard.isMatched
		else { return }
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
	}
}
