//
//  PhotoResponse.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 12.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Decodable, Identifiable {

    var id: String
    var created_at: String
    var likes: Int
    var color: String? = nil
    var width: Int
    var height: Int
    var downloads: Int
    var description: String?
    var urls: PhotoSources?
    var user: PhotoAuthor?
    
    init(id: String, created_at: String, likes: Int, color: String?, width: Int, height: Int, downloads: Int, description: String?, urls: PhotoSources, user: PhotoAuthor) {
        self.id = id
        self.created_at = created_at
        self.likes = likes
        self.color = color
        self.width = width
        self.height = height
        self.downloads = downloads
        self.description = description
        self.urls = urls
        self.user = user
    }

    init(realmModel: RMPhotoResponseModel) {
        self.id = realmModel.id
        self.created_at = realmModel.created_at
        self.likes = realmModel.likes
        self.color = realmModel.color
        self.width = realmModel.width
        self.height = realmModel.height
        self.downloads = realmModel.downloads
        self.description = realmModel.photo_description
        self.urls = realmModel.photo_sources?.asDomain()
        self.user = realmModel.author?.asDomain()
    }
}

// MARK: - PhotoResponse: Hashable
extension PhotoResponse: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(likes)
        hasher.combine(user?.name ?? "")
    }
    
    static func == (lhs: PhotoResponse, rhs: PhotoResponse) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - PhotoAuthor
struct PhotoAuthor: Decodable {
    var name: String
    var username: String
    var instagram_username: String?
    var twitter_username: String?
    
    init(name: String, username: String, instagram_username: String?, twitter_username: String?) {
        self.name = name
        self.username = username
        self.instagram_username = instagram_username
        self.twitter_username = twitter_username
    }
    
    init(realmModel: RMPhotoAuthor) {
        self.name = realmModel.name
        self.username = realmModel.username
        self.instagram_username = realmModel.instagram_username
        self.twitter_username = realmModel.twitter_username
    }
}

// MARK: - PhotoSources
struct PhotoSources: Decodable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
    
    init(raw: String, full: String, regular: String, small: String, thumb: String) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
    
    init(realmModel: RMPhotoSources) {
        self.raw = realmModel.raw
        self.full = realmModel.full
        self.regular = realmModel.regular
        self.small = realmModel.small
        self.thumb = realmModel.thumb
    }
}

// MARK: - PhotoLinks
struct PhotoLinks: Decodable  {
    var `self`: String
    var html: String
    var download: String
    var donwload_location: String
}
