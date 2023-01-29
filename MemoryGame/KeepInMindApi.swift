//
//  KeepInMindApi.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 28/01/2023.
//

import Foundation
import UIKit
import Combine
import EzImageLoader

class KeepInMindAPI {
	
	static let shared = KeepInMindAPI()
	private init() {}
	
	private let baseURL = URL(string: "https://kimserverside.onrender.com")!
	private var token: String {
		return TokenManager.shared.accessToken ?? ""
	}
	
	private var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}
	
	func getScores() -> AnyPublisher<Scores, Error> {
		var request = URLRequest(url: baseURL.appendingPathComponent("/scores"))
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		return URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.data }
			.decode(type: Scores.self, decoder: decoder)
			.eraseToAnyPublisher()
	}
	
	func postScores(score: Score) -> AnyPublisher<Response, Error> {
		var request = URLRequest(url: baseURL.appendingPathComponent("/scores"))
		request.httpMethod = "POST"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		request.httpBody = try! encoder.encode(score)
		
		return URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.data }
			.decode(type: Response.self, decoder: decoder)
			.eraseToAnyPublisher()
	}
	
	func getPhotos() -> AnyPublisher<[UIImage], Error> {
		var request = URLRequest(url: baseURL.appendingPathComponent("/photos"))
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		return URLSession.shared
			.dataTaskPublisher(for: request)
			.map { $0.data }
			.decode(type: [URL].self, decoder: decoder)
			.flatMap { urls in
				Publishers.Sequence(
					sequence: urls.map { url in KeepInMindAPI.shared.getImage(from: url) }
				)
				.flatMap { $0 }
				.collect()
			}
			.eraseToAnyPublisher()
	}
	
	func getImage(from url: URL) -> AnyPublisher<UIImage, Error> {
		return URLSession.shared
			.dataTaskPublisher(for: url)
			.map { (data, response) -> UIImage? in
				guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return nil }
				return UIImage(data: data)
			}
			.compactMap { $0 }
			.receive(on: DispatchQueue.main)
			.mapError { $0 as Swift.Error }
			.eraseToAnyPublisher()
	}
	
	
}
