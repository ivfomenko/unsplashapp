//
//  RMPhotoAuthor.swift
//  unsplashapp
//
//  Created by admin on 19.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - RMPhotoAuthor
class RMPhotoAuthor: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var instagram_username: String?
    @objc dynamic var twitter_username: String?
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    func customInit(model: PhotoAuthor) {
        self.name = model.name
        self.username = model.username
        self.instagram_username = model.instagram_username
        self.twitter_username = model.twitter_username
    }
    
    convenience init(model: PhotoAuthor) {
        self.init()
        self.name = model.name
        self.username = model.username
        self.instagram_username = model.instagram_username
        self.twitter_username = model.twitter_username
    }
}

// MARK: - RMPhotoAuthor: DomainConvertibleType
extension RMPhotoAuthor: DomainConvertibleType {
    
    typealias DomainType = PhotoAuthor
    
    func asDomain() -> PhotoAuthor {
        return PhotoAuthor(realmModel: self)
    }
    
    func fromDomain(domain: PhotoAuthor) {
        return self.customInit(model: domain)
    }
}
