//
//  EmojisMemoryGameView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

struct EmojisMemoryGameView: View {
	
	@StateObject var viewModel: EmojisMemoryGameViewModel

	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Text(viewModel.timerText)
					.font(.title)
				Spacer()
			}
			Spacer()
			VStack(spacing: 10) {
				Grid(viewModel.cards) { card in
					CardView(
						card: card,
						content: { item in
							Text(item)
								.font(.largeTitle)
						}
					)
					.onTapGesture {
						withAnimation(.easeInOut(duration: 0.5)) {
							self.viewModel.choose(card: card)
						}
					}
					.padding(5)
				}
				.padding(10)
				.foregroundColor(.secondary)
			}
			.padding(.horizontal, 10)
		}
	}
}

struct EmojisMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
		let emojis = ["🥶", "😎", "🤬", "👻", "😈", "🤢"]
		EmojisMemoryGameView(viewModel: EmojisMemoryGameViewModel(emojis: emojis))
		.preferredColorScheme(.light)
		EmojisMemoryGameView(viewModel: EmojisMemoryGameViewModel(emojis: emojis))
		.preferredColorScheme(.dark)
	}
}
