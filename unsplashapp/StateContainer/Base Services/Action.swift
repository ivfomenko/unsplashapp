//
//  Action.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

enum AppAction {
    case setRandomPhotosSearchResult(photos: [PhotoResponse])
    case getRandomPhotos(count: Int)
    
    case addPhotoToFavorites(model: PhotoResponse)
    case removePhotoFromFavorites(model: PhotoResponse)
}
