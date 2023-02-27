//
//  LoginViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 27/02/2023.
//

import SwiftUI
import GoogleSignIn

class LoginViewModel: ObservableObject {
	
	@Published var isLoggedIn: Bool = false
	
	func handleSignInButton() {
		guard
			let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
			let rootViewController = windowScene.windows.first?.rootViewController
		else { return }
		Task {
			guard let result = try? await GIDSignIn.sharedInstance.signIn(
				withPresenting: rootViewController,
				hint: nil,
				additionalScopes: ["https://www.googleapis.com/auth/photoslibrary.readonly"]
			) else { return }
			TokenManager.shared.accessToken = result.user.accessToken.tokenString
			await MainActor.run {
				self.isLoggedIn = true
			}
		}
	}
	
	func restoreLogin() async {
		guard let user = try? await GIDSignIn.sharedInstance.restorePreviousSignIn() else {
			await MainActor.run { self.isLoggedIn = false }
			return
		}
		TokenManager.shared.accessToken = user.accessToken.tokenString
		await MainActor.run { self.isLoggedIn = true }
	}
}
