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

struct Scores: Decodable {
	let scores: [Score]
}

struct Score: Codable {
	let score: String
}

struct Pictures: Decodable {
	let pictures: [Picture]
}

struct Picture: Decodable {
	let pictures_url: URL
}
