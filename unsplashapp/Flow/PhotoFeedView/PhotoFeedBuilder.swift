//
//  PhotoFeedBuilder.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import Swinject

class PhotoFeedBuilder {
    static func build(injector: Container, rootNavigation: Published<ActiveRootView>) -> some View {
        let router = PhotoFeedRouter(injector: injector, rootNavigation: rootNavigation)
        let viewModel = PhotoFeedViewModel(router: router, store: injector.resolve(PhotoStore.self)!)
        let view = PhotoFeedView().environmentObject(viewModel)
        
        return view
    }
}
