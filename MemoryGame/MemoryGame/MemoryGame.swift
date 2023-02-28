//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 02/12/2022.
//

import Foundation
import Combine

protocol MemoryGame {
	associatedtype Content
	
	var cards: [Card<Content>] { get }
	
	mutating func choose(card: Card<Content>)
	
	var time: Int { get }
	
	func sendScore() -> AnyPublisher<Response, Error>
}

extension MemoryGame {
	func sendScore() -> AnyPublisher<Response, Error> {
		let score: Score = {
			if time < 10 {
				return Score(score: "300")
			} else if time < 20 {
				return Score(score: "200")
			}
			return Score(score: "100")
		}()
		return KeepInMindAPI.shared
			.postScores(score: score)
			.eraseToAnyPublisher()
	}
}
