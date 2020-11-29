//
//  SideMenuView.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 04.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - SideMenuView
struct SideMenuView: View {
    
    // - EnvironmentObject
    @EnvironmentObject private var viewModel: SideMenuViewModel

}

// MARK: - body
extension SideMenuView {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14.0) {
                ForEach(self.viewModel.items, id: \.hashValue) { item in
                    Button(
                        action: {
                            item.action?()
                        },
                        label: {
                            VStack(
                                alignment: .center,
                                spacing: 8.0,
                                content: {
                                    Image(item.imageName).renderingMode(.template).foregroundColor(.black)
                                    Text(item.title).foregroundColor(.black).font(.body)
                                }
                            )
                        }
                    )
                    .frame(width: 100.0, height: 50.0)
                }
                Spacer()
            }
            .frame(width: 100.0)
            Spacer()
        }
    }
}

#if DEBUG
//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        let items = [SideMenuItem(action: nil, title: "Profile", imageName: "icProfile"), SideMenuItem(action: nil, title: "Info", imageName: "icInfo")]
//        SideMenuView(items: items)
//    }
//}
#endif
