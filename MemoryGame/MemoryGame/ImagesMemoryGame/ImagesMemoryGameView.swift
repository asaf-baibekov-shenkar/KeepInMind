//
//  ImagesMemoryGameView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 20/12/2022.
//

import SwiftUI

struct ImagesMemoryGameView: View {
	
	@StateObject var viewModel: ImagesMemoryGameViewModel
	
    var body: some View {
		VStack(spacing: 10) {
			Grid(viewModel.cards) { card in
				CardView(
					card: card,
					content: { item in
						Image(uiImage: item.image)
							.resizable()
							.scaledToFit()
							.cornerRadius(10.0)
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

struct ImagesMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesMemoryGameView(viewModel: ImagesMemoryGameViewModel(images: []))
    }
}
