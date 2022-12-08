//
//  Grid.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 05/12/2022.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
	private var items: [Item]
	private var viewForItem: (Item) -> ItemView

	init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
		self.items = items
		self.viewForItem = viewForItem
	}

	var body: some View {
		GeometryReader { geometry in
			let layout = GridLayout(itemCount: self.items.count, in: geometry.size)
			ForEach(items) { item in
				if let index = items.firstIndex(where: { $0.id == item.id }) {
					self.viewForItem(item)
						.frame(width: layout.itemSize.width, height: layout.itemSize.height)
						.position(layout.location(ofItemAt: index))
				}
			}
		}
	}
}

struct GridView_Previews: PreviewProvider {
	static var cards: [Card<String>] = [
		Card(id: 0, match_id: 0, content: "a"),
		Card(id: 1, match_id: 0, content: "b")
	]
	static var previews: some View {
		Grid(cards) { item in
			ZStack {
				RoundedRectangle(cornerRadius: 20)
					.stroke(lineWidth: 3)
					.fill(.red)
				Text("\(item.content)")
			}
		}
	}
}
