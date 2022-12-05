//
//  ContentView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

struct ContentView: View {
	
	@ObservedObject var emojiMemoryGame = EmojiMemoryGame()

	var body: some View {
		VStack(spacing: 10) {
			Grid(emojiMemoryGame.cardViewModels) { cardViewModel in
				CardView(viewModel: cardViewModel)
					.onTapGesture {
						self.emojiMemoryGame.choose(card: cardViewModel.card)
					}
					.padding(5)
			}
			.padding(10)
			.foregroundColor(.secondary)
		}
		.padding(.horizontal, 10)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.light)
		ContentView()
			.preferredColorScheme(.dark)
	}
}
