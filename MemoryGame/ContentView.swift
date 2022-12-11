//
//  ContentView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 11/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		NavigationView {
			VStack(alignment: .center) {
				Text("Choose Game")
					.font(.title)
				
				NavigationLink(destination: EmojisMemoryGameView()) {
					Text("Emojis Memory Game")
				}
				.padding(10)
				.background(.blue)
				.cornerRadius(10)
				.foregroundColor(.white)
				
				NavigationLink(destination: PhotosPickerView()) {
					Text("Images Memory Game")
				}
				.padding(10)
				.background(.blue)
				.cornerRadius(10)
				.foregroundColor(.white)
			}
			.navigationTitle("Memory Game")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
