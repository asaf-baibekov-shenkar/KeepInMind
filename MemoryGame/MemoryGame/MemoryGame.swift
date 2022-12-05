//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import Foundation

protocol MemoryGame {
	associatedtype Content
	
	var cards: [Card<Content>] { get }
	
	mutating func choose(card: Card<Content>)
}
