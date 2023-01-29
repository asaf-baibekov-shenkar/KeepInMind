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
	
	func handleSignInButton() {
		guard
			let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
			let rootViewController = windowScene.windows.first?.rootViewController
		else { return }
		GIDSignIn.sharedInstance.signIn(
			withPresenting: rootViewController,
			hint: nil,
			additionalScopes: ["https://www.googleapis.com/auth/photoslibrary.readonly"],
			completion: { (signInResult, error) in
				guard let result = signInResult else { return }
				TokenManager.shared.accessToken = result.user.accessToken.tokenString
			}
		)
	}
	
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
