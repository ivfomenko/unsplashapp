//
//  SideMenuItem.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 04.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

// MARK: - Item
struct SideMenuItem {
    var action: (() -> Void)?
    var title: String
    var imageName: String
}

// MARK: - SideMenuItem: Hashable
extension SideMenuItem: Hashable {
    static func == (lhs: SideMenuItem, rhs: SideMenuItem) -> Bool {
            return lhs.title == rhs.title && lhs.imageName == rhs.imageName
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(imageName)
        }
}
