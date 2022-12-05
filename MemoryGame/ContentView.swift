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
			ForEach(emojiMemoryGame.cardViewModels, id: \.id) { cardViewModel in
				CardView(viewModel: cardViewModel)
			}
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
