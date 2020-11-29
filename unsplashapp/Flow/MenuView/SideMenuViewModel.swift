//
//  SideMenuViewModel.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import SwiftUI

class SideMenuViewModel: ObservableObject {
    // - Internal Properties
    var items: [SideMenuItem]
    
    // - Private Propreties
    private var router: SideMenuRouter
    
    // - Init
    init(router: SideMenuRouter, items: [SideMenuItem]) {
        self.router = router
        self.items = items
    }
}
