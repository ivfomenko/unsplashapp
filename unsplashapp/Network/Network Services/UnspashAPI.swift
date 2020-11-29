//
//  UnspashAPIService.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 10.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

// MARK: - APIService
enum APIService {
    case blank
}

// MARK: - APIService: APITarget
extension APIService: APITarget {

    var baseURL: URL {
        return URL(string: "test")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .blank:
            return .GET
        }
    }
    
    var path: String {
        return ""
    }
    
    var headers: [String: String]? {
        switch self {
        case .blank:
            return ["test": "test"]
        }
    }
    
    var request: URLRequest {
        let path = self.baseURL.appendingPathComponent(self.path)
        var request = URLRequest(url: path)
        request.httpMethod = self.method.rawValue
        headers?.forEach({ key, value in
            request.addValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
}
