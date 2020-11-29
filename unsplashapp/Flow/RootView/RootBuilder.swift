//
//  RootBuilder.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import SwiftUI
import Swinject

class RootBuilder {
    static func build(injector: Container) -> some View {
        let router = RootRouter(injector: injector)
        let viewModel = RootViewModel(router: router)
        
        let view = RootView().environmentObject(viewModel)
        return view
    }
}
