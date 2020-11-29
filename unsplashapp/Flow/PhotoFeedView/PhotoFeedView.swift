//
//  PhotoFeedView.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI

// MARK: - Main
struct PhotoFeedView: View {
    
    // - EnvironmentObject
    @EnvironmentObject private var viewModel: PhotoFeedViewModel
    
    // - State
    @State private var show = false
    @State private var isMenuShowed = false
    @State private var showDetailView = false

    // - States for details image showing
    @State private var startDetails = false
    @Namespace private var namespace
    @State private var selectedModel: PhotoResponse?

    // - Init
    init() {
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
    
    // - Logic Protocol
    private func loadMoreItems() {
        self.viewModel.loadPhotos()
    }
    
    private func calculatePreferedImageHeight(view geometry: CGSize, item imageSize: CGSize) -> CGSize {
        if imageSize.width >= imageSize.height {
            let aspectRatio = imageSize.width / imageSize.height
            let preferedImageHeight = geometry.width * CGFloat(aspectRatio)
            return CGSize(width: geometry.width, height: preferedImageHeight <= 0.0 ? geometry.width : preferedImageHeight)
        } else {
            let aspectRatio = imageSize.width / imageSize.height
            let preferedImageHeight = geometry.width / CGFloat(aspectRatio)
            return CGSize(width: geometry.width, height: preferedImageHeight <= 0.0 ? geometry.width : preferedImageHeight)
        }
    }
}

// MARK: - Body
extension PhotoFeedView {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if startDetails {
                    VStack {
                        if let model = self.selectedModel {
                            ZStack {
                                PhotoCell(model: model, likesActionSignaler: self.viewModel.likesActionSignaler)
                                    .matchedGeometryEffect(id: model.id, in: namespace)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            startDetails.toggle()
                                        }
                                    }
                                    .edgesIgnoringSafeArea(.top)
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button(
                                            action: {
                                                withAnimation(.spring()) {
                                                    startDetails.toggle()
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
                
                NavigationView {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(self.viewModel.photos.enumeratedArray(), id: \.element) { index, item in
                                    let size = self.calculatePreferedImageHeight(view: geometry.size, item: CGSize(width: item.width, height: item.height))
                                    PhotoCell(model: item, likesActionSignaler: self.viewModel.likesActionSignaler)
                                        .frame(idealWidth: size.width, idealHeight: size.height)
                                        .onAppear {
                                            if index == (self.viewModel.photos.endIndex - 3) {
                                                self.viewModel.loadPhotos()
                                            }
                                        }
                                        .onTapGesture {
                                            withAnimation(.spring()) {
                                                startDetails.toggle()
                                                selectedModel = item
                                            }
                                        }
                                        .matchedGeometryEffect(id: item.id, in: namespace)
                                }
                            }
                        }
                    }
                    .onAppear {
                        self.viewModel.loadPhotos()
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
                    .navigationBarTitle("Photos for everyone")
                }
                .statusBar(hidden: startDetails ? true : false)
                .opacity(startDetails ? 0.0 : 1.0)
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
            }
        }
    }
}

// MARK: - PreviewProvider
#if DEBUG
struct PhotoFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoFeedView()
    }
}
#endif
