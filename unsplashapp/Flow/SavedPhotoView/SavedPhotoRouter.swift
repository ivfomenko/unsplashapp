//
//  SavedPhotoRouter.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine
import Swinject

class SavedPhotoRouter: Router {
    
    @Published var activeRootView: ActiveRootView
    
    init(injector: Container, rootNavigation: Published<ActiveRootView>) {
        _activeRootView = rootNavigation
        super.init(injector: injector)
    }
    
    func sideMenuView(items: [SideMenuItem]) -> some View {
        let view = SideMenuBuilder.build(injector: self.injector, items: items, rootNavigation:  self._activeRootView)
        return view
    }
}
