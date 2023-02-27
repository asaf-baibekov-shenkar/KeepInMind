//
//  LoginView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 27/02/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
	
	@StateObject var loginViewModel: LoginViewModel
	@StateObject var googlePhotosViewModel = GooglePhotosViewModel()
	
	var body: some View {
		VStack(spacing: 30) {
			Text("Keep In Mind")
				.font(.title)
			HStack {
				Spacer(minLength: 30)
				GoogleSignInButton(action: loginViewModel.handleSignInButton)
				Spacer(minLength: 30)
			}
		}
		.onOpenURL { url in
			GIDSignIn.sharedInstance.handle(url)
		}
		.onAppear {
			Task {
				await loginViewModel.restoreLogin()
			}
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView(loginViewModel: LoginViewModel())
	}
}
