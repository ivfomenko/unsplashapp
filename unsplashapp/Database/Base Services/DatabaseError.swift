//
//  DatabaseError.swift
//  unsplashapp
//
//  Created by admin on 17.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

enum DatabaseError: Error {
    case unExpectedError
    case objectNotExists
    case saveFailed(String)
    case deleteFailed(String)
    
    var localizedDescription: String {
            switch self {
            case .unExpectedError:
                return "unexpect error for data base layer"
            case .objectNotExists:
                return "Object not exists"
            case .saveFailed(let className):
                return "Database Error Occured: \"\(className)\" object(s) save failed."
            case .deleteFailed(let className):
                return "Database Error Occured: \"\(className)\" object(s) delete failed."
            }
        }
}
