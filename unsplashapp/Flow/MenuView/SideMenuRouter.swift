//
//  SideMenuRouter.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine
import Swinject

// MARK: - SideMenuRouter
class SideMenuRouter: Router {
    @Published var activeRootView: ActiveRootView
    
    init(injector: Container, rootNavigation: Published<ActiveRootView>) {
        _activeRootView = rootNavigation
        super.init(injector: injector)
    }
}
