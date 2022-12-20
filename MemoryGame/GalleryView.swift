//
//  PhotosPickerView.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 11/12/2022.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
	
	@State var galleryPhotos: [GalleryPhotoModel]
	
	var body: some View {
		ScrollView {
			VStack {
				ForEach(galleryPhotos) { galleryPhoto in
					Image(uiImage: galleryPhoto.image)
						.resizable()
						.scaledToFit()
						.cornerRadius(10.0)
						.padding(.horizontal)
				}
			}
		}
	}
}

struct PhotosPickerView_Previews: PreviewProvider {
	static var previews: some View {
		GalleryView(galleryPhotos: [])
	}
}
