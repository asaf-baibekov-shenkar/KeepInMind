//
//  ContentView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 11/12/2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
	
	@State private var path = NavigationPath()
	@StateObject var contentViewModel = ContentViewModel()
	@StateObject var photosPickerViewModel = PhotosPickerViewModel()
	@StateObject var googlePhotosViewModel = GooglePhotosViewModel()
	
    var body: some View {
		NavigationStack(path: $path) {
			VStack(alignment: .center) {
				
				Text("Choose Game")
					.font(.title)
				
				CustomButton("Emojis Memory Game") {
					path.append(["🥶", "😎", "🤬", "👻", "😈", "🤢"])
				}
				
				PhotosPicker(
					selection: $photosPickerViewModel.selectedPhotos,
					matching: .any(of: [.images]),
					photoLibrary: .shared(),
					label: {
						Text("Images Memory Game")
							.padding(10)
							.background(.blue)
							.cornerRadius(10)
							.foregroundColor(.white)
					}
				)
				
				CustomButton("Google Images Memory Game") {
					googlePhotosViewModel.getPhotos()
				}
				
				CustomButton("Scoreboard") {
					contentViewModel.fetchScores()
				}
			}
			.navigationDestination(for: [GalleryPhotoModel].self) { galleryPhotos in
				ImagesMemoryGameView(
					viewModel: ImagesMemoryGameViewModel(
						images: galleryPhotos
					)
				)
			}
			.navigationDestination(for: [String].self) { emojis in
				EmojisMemoryGameView(
					viewModel: EmojisMemoryGameViewModel(
						emojis: emojis
					)
				)
			}
			.navigationDestination(for: Scores.self) { scores in
				ScoreboardView(scores: scores)
			}
			.navigationTitle("Memory Game")
			.onChange(
				of: photosPickerViewModel.didFinishedLoadingImages,
				perform: { didFinished in
					guard didFinished else { return }
					path.append(photosPickerViewModel.loadedImages)
				}
			)
			.onChange(
				of: googlePhotosViewModel.images,
				perform: { images in
					guard !images.isEmpty else { return }
					path.append(images.map { GalleryPhotoModel(image: $0, data: Data()) })
				}
			)
			.onChange(
				of: contentViewModel.scores,
				perform: { scores in
					guard let scores else { return }
					path.append(scores)
				}
			)
			.onAppear(perform: photosPickerViewModel.resetSelectedPhotos)
		}
    }
	
	@ViewBuilder
	func CustomButton(_ title: String, action: @escaping () -> Void) -> some View {
		Button(title, action: action)
		.padding(10)
		.background(.blue)
		.cornerRadius(10)
		.foregroundColor(.white)
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
