//
//  Decodables.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 28/01/2023.
//

import Foundation

struct Response: Decodable {
	let message: String
}

struct Scores: Decodable, Equatable, Hashable {
	
	let scores: [Score]
	
	static var example: Scores {
		return .init(
			scores: [
				.init(score: "100"),
				.init(score: "200"),
				.init(score: "300"),
			]
		)
	}
}

struct Score: Codable, Hashable {
	let score: String
}

struct Pictures: Decodable {
	let pictures: [Picture]
}

struct Picture: Decodable {
	let pictures_url: URL
}
