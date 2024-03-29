//
//  Card.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import SwiftUI

class Card<Item>: Identifiable, ObservableObject {
	var id: Int = 0
	var match_id: Int
	
	@Published var isFaceUp: Bool
	@Published var isMatched: Bool
	@Published var item: Item
	
	init(id: Int, match_id: Int, isFaceUp: Bool = false, isMatched: Bool = false, item: Item) {
		self.id = id
		self.match_id = match_id
		self.isFaceUp = isFaceUp
		self.isMatched = isMatched
		self.item = item
	}
}

extension Card: CustomStringConvertible {
	var description: String {
		return "id: \(self.id), match_id: \(match_id), isFaceUp: \(isFaceUp), isMatched: \(isMatched), content: \(item)"
	}
}
