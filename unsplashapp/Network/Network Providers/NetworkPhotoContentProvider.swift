//
//  NetworkPhotoContentProvider.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 12.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine

// MARK: - NetworkPhotoContentProviderProtocol
protocol NetworkPhotoContentProviderProtocol {
    /// Get random photos from user's feed. By Default should return 30 photos to you.
    func getRandomPhotos(model: GetRandomPhotoSendModel) -> AnyPublisher<[PhotoResponse], Error>
    
    /// Set like to photo by it's id
    func likePhoto(id: String) -> AnyPublisher<LikePhotoResponse, Error>
    
    /// Remove you like from selected photo by it's id
    func unLikePhoto(id: String) -> AnyPublisher<LikePhotoResponse, Error>
}

// MARK: - NetworkPhotoContentProvider
class NetworkPhotoContentProvider: NetworkProvider, NetworkPhotoContentProviderProtocol {
    
    func getRandomPhotos(model: GetRandomPhotoSendModel) -> AnyPublisher<[PhotoResponse], Error> {
        return self.request(.getRandomPhotos(model: model))
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func likePhoto(id: String) -> AnyPublisher<LikePhotoResponse, Error> {
        return self.request(.likePhoto(id: id))
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func unLikePhoto(id: String) -> AnyPublisher<LikePhotoResponse, Error> {
        return self.request(.likePhoto(id: id))
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}
