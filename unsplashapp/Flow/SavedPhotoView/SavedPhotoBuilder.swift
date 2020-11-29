//
//  SavedPhotoBuilder.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import Swinject

class SavedPhotoBuilder {
    static func build(injector: Container, rootNavigation: Published<ActiveRootView>) -> some View {
        let router = SavedPhotoRouter(injector: injector, rootNavigation: rootNavigation)
        let viewModel = SavedPhotoViewModel(router: router, store: injector.resolve(PhotoStore.self)!)
        let view = SavedPhotoView().environmentObject(viewModel)
        
        return view
    }
}
