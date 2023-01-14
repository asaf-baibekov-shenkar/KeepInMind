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
		ZStack {
			Group {
				RoundedRectangle(cornerRadius: cornerRadius)
					.fill(Color.white)
				RoundedRectangle(cornerRadius: cornerRadius)
					.stroke(lineWidth: lineWidth)
					.fill(backgroundColor)
				content(card.item)
					.padding(lineWidth)
			}
			.opacity(card.isFaceUp ? 1.0 : 0.0)
			RoundedRectangle(cornerRadius: cornerRadius)
				.fill(!card.isMatched ? backgroundColor : .white)
				.opacity(!card.isFaceUp ? 1.0 : 0.0)
			if card.isMatched {
				RoundedRectangle(cornerRadius: cornerRadius)
					.stroke(lineWidth: lineWidth)
					.fill(.black)
					.opacity(!card.isFaceUp ? 1.0 : 0.0)
			}
		}
		.rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
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
