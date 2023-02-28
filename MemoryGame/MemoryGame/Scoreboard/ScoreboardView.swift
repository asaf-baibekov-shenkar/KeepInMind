//
//  ScoreboardView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 27/02/2023.
//

import SwiftUI

struct ScoreboardView: View {
	
	var scores: Scores
	
	var body: some View {
		List {
			ForEach(scores.scores, id: \.self) { score in
				Text(score.score)
			}
		}
		.navigationTitle("Scoreboard")
	}
}

struct ScoreboardView_Previews: PreviewProvider {
	static var previews: some View {
		ScoreboardView(scores: .example)
	}
}
