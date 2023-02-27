//
//  GooglePhotosViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 28/01/2023.
//

import SwiftUI
import Combine
import GoogleSignIn

class GooglePhotosViewModel: ObservableObject {
	
	@Published var images: [UIImage] = []
	private var cancelables = Set<AnyCancellable>()
	
	func getPhotos() {
		KeepInMindAPI.shared
			.getPhotos()
			.sink(
				receiveCompletion: { _ in },
				receiveValue: { images in
					self.images = images
				}
			)
			.store(in: &cancelables)
	}
}
