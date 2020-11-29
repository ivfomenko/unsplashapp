//
//  PhotosServiceContainer.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine
import Swinject


class PhotosServiceContainer: ServiceContainer {
    
    var photoContentProvider: NetworkPhotoContentProviderProtocol
    var databasePhotoProvider: DatabasePhotoContentProviderProtocol
    
    init(photoContentProvider: NetworkPhotoContentProviderProtocol, databasePhotoProvider: DatabasePhotoContentProviderProtocol) {
        self.photoContentProvider = photoContentProvider
        self.databasePhotoProvider = databasePhotoProvider
    }
}
