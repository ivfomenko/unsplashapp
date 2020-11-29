//
//  PhotosAppState.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine

// MARK: - PhotosAppState
class PhotosAppState: AppState {
    
    // - AppState main Data
    @Published var randomPhotosFeed: [PhotoResponse] = []
    
    @Published var photoFeedLoadingState: Bool = false
    
    @Published var savedPhotosList: [PhotoResponse] = []

}

// MARK: - PhotosAppState: PhotoFeedAppStateProtocol
extension PhotosAppState: PhotoFeedAppStateProtocol {
    var photosFeedData: Published<[PhotoResponse]>.Publisher  {
        return self.$randomPhotosFeed
    }
    
    var isPhotoFeedRequestInProgress: Published<Bool>.Publisher  {
        return self.$photoFeedLoadingState
    }
    
    var savedPhotos: Published<[PhotoResponse]>.Publisher {
        return self.$savedPhotosList
    }
}
