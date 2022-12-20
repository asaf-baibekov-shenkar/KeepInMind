//
//  PhotosPickerViewModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 19/12/2022.
//

import SwiftUI
import PhotosUI

class PhotosPickerViewModel: ObservableObject {
	@Published var didFinishedLoadingImages: Bool = false
	@Published var loadedImages: [GalleryPhotoModel] = []
	@Published var selectedPhotos: [PhotosPickerItem] = [] {
		didSet {
			Task {
				await MainActor.run {
					self.didFinishedLoadingImages = false
					self.loadedImages = []
				}
				for photo in selectedPhotos {
					await processPhoto(photo: photo)
				}
				await MainActor.run {
					self.didFinishedLoadingImages = !loadedImages.isEmpty
				}
			}
		}
	}
	
	func processPhoto(photo: PhotosPickerItem) async {
		guard let data = try? await photo.loadTransferable(type: Data.self) else { return }
		await MainActor.run {
			if let image = UIImage(data: data) {
				self.loadedImages.append(.init(image: image, data: data))
			}
		}
	}
	
	func resetSelectedPhotos() {
		self.selectedPhotos = []
	}
}

