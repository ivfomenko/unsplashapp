//
//  PhotoCellLikeActionType.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

enum PhotoCellLikeActionType {
    case like(model: PhotoResponse)
    case dislike(model: PhotoResponse)
}
