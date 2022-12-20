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
	@StateObject var photosPickerViewModel = PhotosPickerViewModel()
	
    var body: some View {
		NavigationStack(path: $path) {
			VStack(alignment: .center) {
				Text("Choose Game")
					.font(.title)
				
				NavigationLink(destination: EmojisMemoryGameView()) {
					Text("Emojis Memory Game")
						.padding(10)
						.background(.blue)
						.cornerRadius(10)
						.foregroundColor(.white)
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
			}
			.navigationDestination(for: [GalleryPhotoModel].self) { galleryPhotos in
				GalleryView(galleryPhotos: galleryPhotos)
			}
			.navigationTitle("Memory Game")
			.onChange(
				of: photosPickerViewModel.didFinishedLoadingImages,
				perform: { didFinished in
					guard didFinished else { return }
					path.append(photosPickerViewModel.loadedImages)
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
