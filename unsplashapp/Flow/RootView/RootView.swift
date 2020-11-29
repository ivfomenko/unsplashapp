//
//  RootView.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI

// MARK: - Main
struct RootView: View {
    
    // - EnvironmentObject
    @EnvironmentObject private var viewModel: RootViewModel

}

// MARK: - Body
extension RootView {
    var body: some View {
        ZStack {
            switch self.viewModel.activeRootView {
            case .photoFeed:
                self.viewModel.photoFeedView()
            case .savedPhotos:
                self.viewModel.savedPhotosView()
            }
        }
    }
}

// MARK: - PreviewProvider
#if DEBUG

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
