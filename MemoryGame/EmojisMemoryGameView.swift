//
//  EmojisMemoryGameView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

struct EmojisMemoryGameView: View {
	
	@ObservedObject var emojiMemoryGame = EmojiMemoryGame()

	var body: some View {
		VStack(spacing: 10) {
			Grid(emojiMemoryGame.cards) { card in
				CardView(card: card)
					.onTapGesture {
						self.emojiMemoryGame.choose(card: card)
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
		EmojisMemoryGameView()
			.preferredColorScheme(.light)
		EmojisMemoryGameView()
			.preferredColorScheme(.dark)
	}
}
