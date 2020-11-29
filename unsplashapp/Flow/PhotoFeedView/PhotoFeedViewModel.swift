//
//  PhotoFeedViewModel.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import SwiftUI

class PhotoFeedViewModel: ObservableObject {
    
    var likesActionSignaler = PassthroughSubject<PhotoCellLikeActionType, Error>()
    
    // - Internal propreties
    @Published var photos: [PhotoResponse] = []
    @Published var isLoadRequestInProgress: Bool = false
    
    // - Private properties
    private var router: PhotoFeedRouter
    private var store: PhotoFeedStoreProtocol
    
    // - Private Properties
    private lazy var menuItems: [SideMenuItem] = {
        let items: [SideMenuItem] = [
            SideMenuItem(
                action: { [weak self] in
                    withAnimation {
                        self?.router.activeRootView = .savedPhotos
                    }
                },
                title: "Saved",
                imageName: "ic_Like"),
            SideMenuItem(
                action: nil,
                title: "Info",
                imageName: "icInfo")
        ]
        return items
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    // - Init
    init(router: PhotoFeedRouter, store: PhotoFeedStoreProtocol) {
        self.router = router
        self.store = store
        self.binding()
    }
    
    // - Internal Logic
    func sideMenuView() -> some View {
        return self.router.sideMenuView(items: menuItems)
    }
    
    func loadPhotos() {
        self.store.loadPhotos(count: 30)
    }
    
    // - Private Logic
    private func binding() {
        self.store.photoFeedState.photosFeedData.receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.photos.append(contentsOf: value)
            }
            .store(in: &cancellables)
        
        self.store.photoFeedState.isPhotoFeedRequestInProgress.receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.isLoadRequestInProgress = value
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
