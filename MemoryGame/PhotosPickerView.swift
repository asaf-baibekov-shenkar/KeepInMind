//
//  PhotosPickerView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 11/12/2022.
//

import SwiftUI
import PhotosUI

class PhotosPickerViewModel: ObservableObject {
	@Published var selectedPhotosData = [UIImage]()
	@Published var selectedItems = [PhotosPickerItem]()
	
	func loadImages(items: [PhotosPickerItem]) {
		items.forEach { item in
			Task {
				guard let data = try? await item.loadTransferable(type: Data.self),
					  let image = UIImage(data: data) else { return }
				await MainActor.run {
					selectedPhotosData.append(image)
				}
			}
		}
	}
}


struct PhotosPickerView: View {
	
	@StateObject var photosPickerViewModel = PhotosPickerViewModel()
	
	var body: some View {
		ScrollView {
			VStack {
				ForEach(photosPickerViewModel.selectedPhotosData, id: \.self) { image in
					Image(uiImage: image)
						.resizable()
						.scaledToFit()
						.cornerRadius(10.0)
						.padding(.horizontal)
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				PhotosPicker(
					selection: $photosPickerViewModel.selectedItems,
					maxSelectionCount: 4,
					matching: .images,
					label: {
						Image(systemName: "photo.on.rectangle.angled")
					}
				)
				.onChange(
					of: photosPickerViewModel.selectedItems,
					perform: photosPickerViewModel.loadImages
				)
			}
		}
	}
}

struct PhotosPickerView_Previews: PreviewProvider {
	static var previews: some View {
		let viewModel = PhotosPickerViewModel()
		PhotosPickerView(photosPickerViewModel: viewModel)
	}
}
