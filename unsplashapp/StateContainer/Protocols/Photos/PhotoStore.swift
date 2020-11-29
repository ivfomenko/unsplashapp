//
//  PhotoStore.swift
//  unsplashapp
//
//  Created by admin on 16.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine

class PhotoStore: Store {
    
    // - Private Properties for redux container
    @Published private var state: PhotosAppState
    private let environment: PhotosServiceContainer
    private var cancellables: Set<AnyCancellable> = []
    
    // - Init
    init(initialState: PhotosAppState, environment: PhotosServiceContainer) {
        self.state = initialState
        self.environment = environment
        super.init(initialState: initialState, environment: environment)
        self.binding()
    }
    
    // - appReducer
    override func appReducer(state: inout AppState, action: AppAction, environment: ServiceContainer) -> AnyPublisher<AppAction, Never> {
        switch action {

        case let .setRandomPhotosSearchResult(photos):
            self.state.photoFeedLoadingState = false
            self.state.randomPhotosFeed.append(contentsOf: photos)
            
        case let .getRandomPhotos(count):
            let sendModel = GetRandomPhotoSendModel(count: count, orientation: .landscape)
            return self.environment.photoContentProvider.getRandomPhotos(model: sendModel)
                .replaceError(with: [])
                .map({ AppAction.setRandomPhotosSearchResult(photos: $0) })
                .eraseToAnyPublisher()
            
        case let .addPhotoToFavorites(model):
            self.environment.databasePhotoProvider.savePhoto(model: model)
                .sink { _ in } receiveValue: { _ in }
                .store(in: &cancellables)

        case let .removePhotoFromFavorites(model):
            self.environment.databasePhotoProvider.deletePhoto(model: model)
                .sink { _ in } receiveValue: { _ in }
                .store(in: &cancellables)
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    private func binding() {
        self.environment.databasePhotoProvider
            .subscribeOnSavedPhotos()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { value in
                    self.state.savedPhotosList = value
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: - PhotoStore: PhotoFeedStoreProtocol
extension PhotoStore: PhotoFeedStoreProtocol {
    
    var photoFeedState: PhotoFeedAppStateProtocol {
        return self.state
    }
    
    func loadPhotos(count: Int) {
        guard !self.state.photoFeedLoadingState else { return }
        self.state.photoFeedLoadingState = true
        self.send(.getRandomPhotos(count: count))
    }
    
    func addPhotoToFavorite(model: PhotoResponse) {
        self.send(.addPhotoToFavorites(model: model))
    }
    
    func removePhotoFromFavorite(model: PhotoResponse) {
        self.send(.removePhotoFromFavorites(model: model))
    }
    
}
