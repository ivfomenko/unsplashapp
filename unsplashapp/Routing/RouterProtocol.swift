//
//  RouterProtocol.swift
//  unsplashapp
//
//  Created by admin on 27.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import UIKit
import Swinject

// MARK: - RouterProtocol
protocol RouterProtocol: class {
    var injector: Container { get set }
}

// MARK: - Router
class Router: RouterProtocol {
    var injector: Container
    
    init(injector: Container) {
        self.injector = injector
    }
}
