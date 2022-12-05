//
//  CardViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 01/12/2022.
//

import SwiftUI

class CardViewModel: ObservableObject, Identifiable {
	
	private(set) var card: Card<String>
	
	init(card: Card<String>) {
		self.card = card
	}
}
