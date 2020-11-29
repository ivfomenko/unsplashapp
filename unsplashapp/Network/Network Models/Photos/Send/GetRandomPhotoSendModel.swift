//
//  GetRandomPhotoSendModel.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 12.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

struct GetRandomPhotoSendModel: Codable {
    var count: Int = 30
    var orientation: PhotoOrientation
}

enum PhotoOrientation: String, Codable {
    case landscape
    case portrait
    case squarish
}
