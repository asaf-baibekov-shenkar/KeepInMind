//
//  ContentViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 27/02/2023.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
	
	@Published var scores: Scores?
	
	private var cancellables = Set<AnyCancellable>()
	
	func fetchScores() {
		KeepInMindAPI.shared
			.getScores()
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { completion in
					print(completion)
				},
				receiveValue: { scores in
					self.scores = scores
				}
			)
			.store(in: &cancellables)
	}
}
