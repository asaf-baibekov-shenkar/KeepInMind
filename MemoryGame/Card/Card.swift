//
//  Card.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import SwiftUI

struct Card<Content>: Identifiable {
	var id: Int = 0

	var isFaceUp: Bool = true
	var isMatched: Bool = false
	var content: Content
}
