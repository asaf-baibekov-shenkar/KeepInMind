//
//  CardView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

struct CardView: View {
	
	@StateObject var viewModel: CardViewModel
	
	@State var cornerRadius: CGFloat = 20
	@State var lineWidth: CGFloat = 3
	@State var iconFontScaleFactor: CGFloat = 0.66
	@State var backgroundColor: Color = .red
	
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			ZStack {
				if viewModel.card.isFaceUp {
					RoundedRectangle(cornerRadius: cornerRadius)
						.fill(Color.white)
					RoundedRectangle(cornerRadius: cornerRadius)
						.stroke(lineWidth: lineWidth)
						.fill(backgroundColor)
					Text(viewModel.card.content)
						.font(.largeTitle)
				} else if !viewModel.card.isMatched {
					RoundedRectangle(cornerRadius: self.cornerRadius)
						.fill(backgroundColor)
				}
			}
			.font(Font.system(size: min(size.width, size.height) * iconFontScaleFactor))
		}
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(
			viewModel: CardViewModel(
				card: Card(isFaceUp: false, content: "✈️")
			),
			backgroundColor: .red
		)
	}
}
