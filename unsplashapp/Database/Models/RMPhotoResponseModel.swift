//
//  RMPhotoResponseModel.swift
//  unsplashapp
//
//  Created by admin on 19.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - RMPhotoResponseModel
class RMPhotoResponseModel: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var created_at: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var color: String?
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var downloads: Int = 0
    @objc dynamic var photo_description: String?
    @objc dynamic var author: RMPhotoAuthor?
    @objc dynamic var photo_sources: RMPhotoSources?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func customInit(model: PhotoResponse) {
        self.id = model.id
        self.created_at = model.created_at
        self.likes = model.likes
        self.color = model.color
        self.width = model.width
        self.height = model.height
        self.downloads = model.downloads
        self.photo_description = model.description
        
        if let user = model.user {
            self.author = RMPhotoAuthor(model: user)
        }
       
        if let sources = model.urls {
            self.photo_sources = RMPhotoSources(model: sources)
        }
    }
    
    convenience init(model: PhotoResponse) {
        self.init()
        self.id = model.id
        self.created_at = model.created_at
        self.likes = model.likes
        self.color = model.color
        self.width = model.width
        self.height = model.height
        self.downloads = model.downloads
        self.photo_description = model.description
        
        if let user = model.user {
            self.author = RMPhotoAuthor(model: user)
        }
       
        if let sources = model.urls {
            self.photo_sources = RMPhotoSources(model: sources)
        }
    }
}

// MARK: - RMPhotoResponseModel: DomainConvertibleType
extension RMPhotoResponseModel: DomainConvertibleType {
    
    typealias DomainType = PhotoResponse
    
    func asDomain() -> PhotoResponse {
        return PhotoResponse(realmModel: self)
    }
    
    func fromDomain(domain: PhotoResponse) {
        return self.customInit(model: domain)
    }
}
