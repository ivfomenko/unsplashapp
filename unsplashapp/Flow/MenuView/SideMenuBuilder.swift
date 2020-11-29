//
//  SideMenuBuilder.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import Swinject

class SideMenuBuilder {
    static func build(injector: Container, items: [SideMenuItem], rootNavigation: Published<ActiveRootView>) -> some View {
        let router = SideMenuRouter(injector: injector, rootNavigation: rootNavigation)
        let viewModel = SideMenuViewModel(router: router, items: items)
        let view = SideMenuView().environmentObject(viewModel)
        return view
    }
}
