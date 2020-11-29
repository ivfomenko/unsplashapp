//
//  PhotoFeedViewControlProtocols.swift
//  unsplashapp
//
//  Created by admin on 22.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine

// MARK: - PhotoFeedStoreProtocol
protocol PhotoFeedStoreProtocol {
    /// Abstract State Protocol for access to AppState Data
    var photoFeedState: PhotoFeedAppStateProtocol { get }
    
    /// Operation for load random photos. Should ignore action in case of isRandomPhotoFeedRequestInProgres true value
    func loadPhotos(count: Int)

    func addPhotoToFavorite(model: PhotoResponse)

    func removePhotoFromFavorite(model: PhotoResponse)
}

// MARK: - PhotoFeedAppStateProtocol
protocol PhotoFeedAppStateProtocol {
    /**
     Data Store for random photos feed. Data presented as Array of PhotoResponse struct.
     Data will automaticly updated by paginated request. Just bind this array to your view data and map what you need.
     */
    var photosFeedData: Published<[PhotoResponse]>.Publisher { get }
    
    /**
     Data Store for saved photos. Data presented as Array of PhotoResponse struct.
     Data will automaticly updated by subscribtion from database. Just bind this array to your view data and map what you need.
     */
    var savedPhotos: Published<[PhotoResponse]>.Publisher { get }
    
    /// Proprety for returning current status of randomPhotosFeed network request
    var isPhotoFeedRequestInProgress: Published<Bool>.Publisher { get }
}
