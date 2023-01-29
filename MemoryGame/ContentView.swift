//
//  ContentView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 11/12/2022.
//

import SwiftUI
import PhotosUI
import GoogleSignInSwift

struct ContentView: View {
	
	@State private var path = NavigationPath()
	@StateObject var photosPickerViewModel = PhotosPickerViewModel()
	@StateObject var googlePhotosViewModel = GooglePhotosViewModel()
	
    var body: some View {
		NavigationStack(path: $path) {
			VStack(alignment: .center) {
				HStack {
					Spacer(minLength: 30)
					GoogleSignInButton(action: googlePhotosViewModel.handleSignInButton)
					Spacer(minLength: 30)
				}
				Text("Choose Game")
					.font(.title)
				Button("Emojis Memory Game") {
					path.append(["🥶", "😎", "🤬", "👻", "😈", "🤢"])
				}
				.padding(10)
				.background(.blue)
				.cornerRadius(10)
				.foregroundColor(.white)
				
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
				
				Button("Google Images Memory Game") {
					googlePhotosViewModel.getPhotos()
				}
				.padding(10)
				.background(.blue)
				.cornerRadius(10)
				.foregroundColor(.white)
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
			.onAppear(perform: photosPickerViewModel.resetSelectedPhotos)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
