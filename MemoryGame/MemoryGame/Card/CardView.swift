//
//  CardView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 25/11/2022.
//

import SwiftUI

struct CardView<Item, Content: View>: View {
	
	@StateObject var card: Card<Item>
	
	@State var cornerRadius: CGFloat = 20
	@State var lineWidth: CGFloat = 3
	@State var iconFontScaleFactor: CGFloat = 0.66
	@State var backgroundColor: Color = .red
	
	let content: (Item) -> Content
	
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			ZStack {
				if card.isFaceUp {
					RoundedRectangle(cornerRadius: cornerRadius)
						.fill(Color.white)
					RoundedRectangle(cornerRadius: cornerRadius)
						.stroke(lineWidth: lineWidth)
						.fill(backgroundColor)
					content(card.item)
				} else if !card.isMatched {
					RoundedRectangle(cornerRadius: self.cornerRadius)
						.fill(backgroundColor)
				} else if card.isMatched {
					RoundedRectangle(cornerRadius: cornerRadius)
						.fill(Color.white)
					RoundedRectangle(cornerRadius: cornerRadius)
						.stroke(lineWidth: lineWidth)
						.fill(.black)
				}
			}
			.font(Font.system(size: min(size.width, size.height) * iconFontScaleFactor))
		}
	}
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView(
			card: Card(id: 0, match_id: 0, isFaceUp: false, item: "✈️"),
			content: { item in
				Text(item)
					.font(.largeTitle)
			}
		)
    }
}
