//
//  Card.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import SwiftUI

class Card<Content>: Identifiable, ObservableObject {
	var id: Int = 0

	var isFaceUp: Bool
	var isMatched: Bool
	var content: Content
	
	init(id: Int, isFaceUp: Bool = true, isMatched: Bool = false, content: Content) {
		self.id = id
		self.isFaceUp = isFaceUp
		self.isMatched = isMatched
		self.content = content
	}
}
