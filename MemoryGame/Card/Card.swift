//
//  Card.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import SwiftUI

class Card<Content>: Identifiable, ObservableObject {
	var id: Int = 0

	@Published var isFaceUp: Bool
	@Published var isMatched: Bool
	@Published var content: Content
	
	init(id: Int, isFaceUp: Bool = false, isMatched: Bool = false, content: Content) {
		self.id = id
		self.isFaceUp = isFaceUp
		self.isMatched = isMatched
		self.content = content
	}
}

extension Card: CustomStringConvertible {
	var description: String {
		return "id: \(self.id), isFaceUp: \(isFaceUp), isMatched: \(isMatched), content: \(content)"
	}
}
