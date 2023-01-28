//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI
import GoogleSignIn

@main
struct MemoryGameApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.onOpenURL { url in
					GIDSignIn.sharedInstance.handle(url)
				}
				.onAppear {
					GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
						print("error", error ?? "nil")
						print("user", user ?? "nil")
					}
				}
		}
	}
}
