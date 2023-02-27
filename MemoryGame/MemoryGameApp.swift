//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

@main
struct MemoryGameApp: App {
	
	@ObservedObject var loginViewModel = LoginViewModel()
	
	var body: some Scene {
		WindowGroup {
			if loginViewModel.isLoggedIn {
				ContentView()
			} else {
				LoginView(loginViewModel: loginViewModel)
			}
		}
	}
}
