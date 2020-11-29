//
//  SavedPhotoViewModel.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import SwiftUI

class SavedPhotoViewModel: ObservableObject {
    
    var likesActionSignaler = PassthroughSubject<PhotoCellLikeActionType, Error>()
    
    // - Internal propreties
    @Published var savedPhotos: [PhotoResponse] = []
    
    // - Private properties
    private var router: SavedPhotoRouter
    private var store: PhotoFeedStoreProtocol
    
    // - Private Properties
    private lazy var menuItems: [SideMenuItem] = {
        let items: [SideMenuItem] = [
            SideMenuItem(
                action: { [weak self] in
                    withAnimation {
                        self?.router.activeRootView = .photoFeed
                    }
                },
                title: "Photo Feed",
                imageName: "ic_Share"),
            SideMenuItem(
                action: nil,
                title: "Info",
                imageName: "icInfo")
        ]
        return items
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    // - Init
    init(router: SavedPhotoRouter, store: PhotoFeedStoreProtocol) {
        self.router = router
        self.store = store
        self.binding()
    }
    
    // - Internal logic
    func sideMenuView() -> some View {
        return self.router.sideMenuView(items: menuItems)
    }
    
    // - Private logic
    private func binding() {
        self.store.photoFeedState.savedPhotos
            .sink { [weak self] value in
                self?.savedPhotos = value
            }
            .store(in: &cancellables)
        
        self.likesActionSignaler
            .sink(
                receiveCompletion: { error in
                    print(error)
                },
                receiveValue: { [weak self] value in
                    switch value {
                    case let .dislike(model):
                        self?.store.removePhotoFromFavorite(model: model)
                    case let .like(model):
                        self?.store.addPhotoToFavorite(model: model)
                    }
                }
            )
            .store(in: &cancellables)
    }
}
