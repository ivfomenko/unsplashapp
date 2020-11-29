//
//  RMPhotoSources.swift
//  unsplashapp
//
//  Created by admin on 19.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - RMPhotoSources
class RMPhotoSources: Object {
    
    @objc dynamic var raw: String = ""
    @objc dynamic var full: String = ""
    @objc dynamic var regular: String = ""
    @objc dynamic var small: String = ""
    @objc dynamic var thumb: String = ""
    
    override class func primaryKey() -> String? {
        return "raw"
    }
    
    func customInit(model: PhotoSources) {
        self.raw = model.raw
        self.full = model.full
        self.regular = model.regular
        self.small = model.small
        self.thumb = model.thumb
    }
    
    convenience init(model: PhotoSources) {
        self.init()
        self.raw = model.raw
        self.full = model.full
        self.regular = model.regular
        self.small = model.small
        self.thumb = model.thumb
    }
}

// MARK: - RMPhotoSources: DomainConvertibleType
extension RMPhotoSources: DomainConvertibleType {
    
    typealias DomainType = PhotoSources
    
    func asDomain() -> PhotoSources {
        return PhotoSources(realmModel: self)
    }
    
    func fromDomain(domain: PhotoSources) {
        self.customInit(model: domain)
    }
}
