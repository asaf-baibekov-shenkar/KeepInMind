//
//  GalleryPhotoModel.swift
//  MemoryGame
//
//  Created by Asaf Baibekov on 19/12/2022.
//

import SwiftUI

struct GalleryPhotoModel: Identifiable, Hashable {
	var id: String = UUID().uuidString
	var image: UIImage
	var data: Data
}
