//
//  SavedPhotoCell.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine
import Kingfisher

// MARK: - SavedPhotoCell
struct SavedPhotoCell: SwiftUI.View {
    var model: PhotoResponse
    
    // - Base
    init(model: PhotoResponse) {
        self.model = model
    }
}

// MARK: - body
extension SavedPhotoCell {
    var body: some SwiftUI.View {
        HStack() {
            if let url = model.urls?.small {
                KFImage(URL(string: url), options: [.transition(.fade(0.2))])
                    .placeholder {
                        ZStack {
                            ActivityIndicator().frame(width: 24.0, height: 24.0, alignment: .center)
                        }
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .center)
            }
            Spacer()
        }
    }
}
