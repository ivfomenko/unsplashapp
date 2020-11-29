//
//  RootRouter.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - RootRouter
class RootRouter: Router {

    func photoFeedView(navigation: Published<ActiveRootView>) -> some View {
        let view = PhotoFeedBuilder.build(injector: self.injector, rootNavigation: navigation)
        return view
    }
    
    func savedPhotosView(navigation: Published<ActiveRootView>) -> some View {
        let view = SavedPhotoBuilder.build(injector: self.injector, rootNavigation: navigation)
        return view
    }
}
