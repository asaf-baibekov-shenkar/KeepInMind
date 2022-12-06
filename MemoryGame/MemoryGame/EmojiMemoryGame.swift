//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 01/12/2022.
//

import Foundation

class EmojiMemoryGame: MemoryGame, ObservableObject {
	typealias Content = String
	
	@Published var cards: [Card<String>]
	
	init() {
		self.cards = ["🥶", "😎", "🤬", "👻", "😈", "🤢"]
			.enumerated()
			.flatMap { (index, element) in
				return [
					Card.init(id: index * 2		, content: element),
					Card.init(id: index * 2 + 1	, content: element)
				]
			}
			.shuffled()
	}
	
	func choose(card: Card<String>) {
		guard let firstIndex = self.cards.firstIndex(where: { $0.id == card.id }) else { return }
		cards[firstIndex].isFaceUp.toggle()
	}
}
