//
//  RootViewModel.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import SwiftUI



class RootViewModel: ObservableObject {
    
    // - Private propreties
    private var router: RootRouter
    
    @Published var activeRootView: ActiveRootView = .photoFeed
    
    // - Init
    init(router: RootRouter) {
        self.router = router
    }
    
    // - Internal View
    func photoFeedView() -> some View {
        return self.router.photoFeedView(navigation: _activeRootView)
    }
    
    func savedPhotosView() -> some View {
        return self.router.savedPhotosView(navigation: _activeRootView)
    }
}
