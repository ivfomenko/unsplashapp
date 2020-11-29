//
//  DatabasePhotoContentProvider.swift
//  unsplashapp
//
//  Created by admin on 19.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

// MARK: - DatabasePhotoContentProviderProtocol
protocol DatabasePhotoContentProviderProtocol {
    /// Return AnyPublisher observable for local data source of photos. Should return array of all photos from local data base in case of any update into local data  table
    func subscribeOnSavedPhotos() -> AnyPublisher<[PhotoResponse], Error>
    
    /// Save photo to local favorite list and return saved object. Ignore response if you don't need it
    func savePhoto(model: PhotoResponse) -> Future<PhotoResponse, Error>
    
    /// Delete photo from local favorite list and return deleted object. Ignore response if you don't need it
    func deletePhoto(model: PhotoResponse) -> AnyPublisher<PhotoResponse?, Error>
}

// MARK: - DatabasePhotoContentProvider
class DatabasePhotoContentProvider {
    
    private var storage: RealmStorageManager
    
    init(storage: RealmStorageManager) {
        self.storage = storage
    }
}

// MARK: - DatabasePhotoContentProvider: DatabasePhotoContentProviderProtocol
extension DatabasePhotoContentProvider: DatabasePhotoContentProviderProtocol {
    
    func subscribeOnSavedPhotos() -> AnyPublisher<[PhotoResponse], Error> {
        return self.storage.subscribeOnDomainObjects(realmType: RMPhotoResponseModel.self)
    }
    
    func savePhoto(model: PhotoResponse) -> Future<PhotoResponse, Error> {
        return self.storage.saveDomainObject(realmType: RMPhotoResponseModel.self, model: model)
    }
    
    func deletePhoto(model: PhotoResponse) -> AnyPublisher<PhotoResponse?, Error> {
        let keys = [model.id]
        return self.storage.removeDomainObjects(realmType: RMPhotoResponseModel.self, with: keys)
            .map(\.first)
            .eraseToAnyPublisher()
    }
}
