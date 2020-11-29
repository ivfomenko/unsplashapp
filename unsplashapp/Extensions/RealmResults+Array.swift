//
//  RealmResults+Array.swift
//  unsplashapp
//
//  Created by admin on 17.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Realm Results -> Array
extension Results {
    /**
     Convert Realm Results<Object> to Array
     Usage: you need write this -> let objects = Realm().objects(YourType).toArray(YourType) as [YourType]
     */
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
