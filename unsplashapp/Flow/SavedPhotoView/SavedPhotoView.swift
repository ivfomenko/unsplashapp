//
//  SavedPhotoView.swift
//  unsplashapp
//
//  Created by admin on 25.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI

// MARK: - SavedPhotoView
struct SavedPhotoView: View {

    // - EnvironmentObject
    @EnvironmentObject private var viewModel: SavedPhotoViewModel
    
    @State private var isMenuShowed = false
    @State private var showDetailView = false
    
    // - States for details image showing
    @Namespace private var namespace
    @State private var detailedModel: PhotoResponse?

    private var spacing: CGFloat = 12.0
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
}

// MARK: - body
extension SavedPhotoView {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if detailedModel == nil {
                    NavigationView {
                        VStack {
                            ScrollView(showsIndicators: false) {
                                let size = (geometry.size.width / 2.0) - self.spacing
                                LazyVGrid(columns: [GridItem(.fixed(size), spacing: self.spacing), GridItem(.fixed(size), spacing: self.spacing)], spacing: self.spacing) {
                                    ForEach(self.viewModel.savedPhotos) { item in
                                        
                                        SavedPhotoCell(model: item)
                                            .frame(width: size, height: size)
                                            .cornerRadius(8.0)
                                            .onTapGesture {
                                                withAnimation {
                                                    detailedModel = item
                                                }
                                            }
                                            .matchedGeometryEffect(id: item.id, in: namespace)
                                            
                                    }
                                }
                            }
                        }
                        .navigationBarItems(
                            leading:
                                Button(action: {
                                    withAnimation {
                                        self.isMenuShowed.toggle()
                                    }
                                }, label: {
                                    Image("icMenu").foregroundColor(.black)
                                })
                        )
                        .navigationBarTitle("Saved Photos")
                    }
                    .statusBar(hidden: detailedModel == nil ? false : true)
                    .opacity(detailedModel == nil ? 1.0 : 0.0)
                    .offset(x: self.isMenuShowed ? 100 : 0)
                    
                    if isMenuShowed {
                        HStack {
                            self.viewModel.sideMenuView()
                                .frame(width: 100)
                                .animation(.spring())
                            Spacer()
                        }
                        
                    } else {
                        EmptyView()
                    }
                    
                } else {
                    VStack {
                        if let model = self.detailedModel {
                            ZStack {
                                PhotoCell(model: model, likesActionSignaler: self.viewModel.likesActionSignaler, liked: true)
                                    .matchedGeometryEffect(id: model.id, in: namespace)
                                    .onTapGesture {
                                        withAnimation {
                                            self.detailedModel = nil
                                        }
                                    }
                                    .edgesIgnoringSafeArea(.top)
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button(
                                            action: {
                                                withAnimation {
                                                    self.detailedModel = nil
                                                }
                                            },
                                            label: {
                                                Image("close")
                                            }
                                        )
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                        .padding(.all, 24.0)
                                    }
                                    Spacer()
                                }
                            }

                        }
                        Spacer()
                    }
                    .background(Color.white)
                }
            }
        }
    }
}

// MARK: - PreviewProvider
#if DEBUG
struct SavedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPhotoView()
    }
}
#endif
