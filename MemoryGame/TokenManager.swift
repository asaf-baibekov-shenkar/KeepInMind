//
//  TokenManager.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 28/01/2023.
//

import Foundation

class TokenManager {
	static let shared = TokenManager()
	
	private let userDefaults = UserDefaults.standard
	
	private var tokenKey: String { "accessToken" }
	private let lock = NSLock()
	
	var accessToken: String? {
		get {
			lock.lock()
			defer { lock.unlock() }
			return userDefaults.string(forKey: tokenKey)
		}
		set {
			lock.lock()
			defer { lock.unlock() }
			userDefaults.set(newValue, forKey: tokenKey)
		}
	}
	
	private init() { }
}
