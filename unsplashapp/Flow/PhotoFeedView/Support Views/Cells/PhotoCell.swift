//
//  PhotoCell.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 18.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine
import Kingfisher

// MARK: - Main
struct PhotoCell: SwiftUI.View {

    // - Internal Modela
    var model: PhotoResponse
    var likesActionSignaler: PassthroughSubject<PhotoCellLikeActionType, Error>
    
    // - State properties
    @State private var liked: Bool
    @State private var showShareSheet = false

    // - Private Store
    private var dataContainer = PhotoCellDataContainer()
    
    // - Base
    init(model: PhotoResponse, likesActionSignaler: PassthroughSubject<PhotoCellLikeActionType, Error>, liked: Bool = false) {
        self.model = model
        self.likesActionSignaler = likesActionSignaler
        self._liked = State<Bool>(wrappedValue: liked)
    }

    // - Private BL
    private func accept(_ image: UIImage) {
        self.dataContainer.sharedItems.append(image)
    }
}

// MARK: - Body
extension PhotoCell {
    var body: some SwiftUI.View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 12.0) {
                HStack() {
                    if let url = model.urls?.regular {
                        KFImage(URL(string: url), options: [.transition(.fade(0.2))])
                            .onSuccess(perform: { result in
                                self.accept(result.image)
                            })
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
                
                VStack(alignment: .leading) {
                    HStack {
                        Button(
                            action: {
                                self.liked.toggle()
                                self.likesActionSignaler.send(liked ? .like(model: self.model) : .dislike(model: self.model))
                            },
                            label: {
                                Image(liked ? "ic_like_filled" : "ic_Like")
                            }
                        )
                        
                        Button(
                            action: {
                                self.showShareSheet.toggle()
                            },
                            label: {
                                ZStack {
                                    Image("ic_Share")
                                }
                            }
                        )
                        
                        Spacer()
                    }
                    
                    HStack() {
                        VStack(alignment: .leading) {
                            Text("\(model.user?.username ?? "Anonymous")").frame(alignment: .leading).font(.headline).lineLimit(nil)
                            Text("\(model.description ?? "")").font(.body).lineLimit(nil)
                        }
                        Spacer()
                    }
                    
                }
                .padding([.trailing, .leading, .bottom], 12.0).clipped()
                
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: self.dataContainer.sharedItems)
            }
        }
    }
}

// MARK: - PreviewProvider
#if DEBUG
struct PhotoCell_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        let signaler = PassthroughSubject<PhotoCellLikeActionType, Error>()
        let author = PhotoAuthor(name: "user", username: "username", instagram_username: nil, twitter_username: nil)
        let photoSources = PhotoSources(raw: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max", full: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max", regular: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max", small: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max", thumb: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max")
        
        let model = PhotoResponse(id: "", created_at: "", likes: 12, color: nil, width: 123, height: 123, downloads: 23, description: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=maxhttps://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=maxhttps://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=maxhttps://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max", urls: photoSources, user: author)
        return Group {
            PhotoCell(model: model, likesActionSignaler: signaler)
            PhotoCell(model: model, likesActionSignaler: signaler)
        }
    }
}
#endif
