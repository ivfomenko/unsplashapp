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
    case getRandomPhotos(model: GetRandomPhotoSendModel)
    case likePhoto(id: String)
    case unLikePhoto(id: String)
}

// MARK: - APIService: APITarget
extension APIService: APITarget {

    var baseURL: String {
        return .baseUrl
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRandomPhotos:
            return .GET
        case .likePhoto:
            return .POST
        case .unLikePhoto:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .getRandomPhotos:
            return "/photos/random"
        case let .likePhoto(id):
            return "/photos/\(id)/like"
        case let .unLikePhoto(id):
            return "/photos/\(id)/like"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .getRandomPhotos(model):
            return URLQueryItem.initFrom(model: model)
        case .likePhoto:
            return []
        case .unLikePhoto:
            return []
        }
    }
    
    var headers: [String: String]? {
        var headers = [
            "Content-type": "application/json"
        ]
        
        if let accessKey = Bundle.main.infoDictionary!["UNSPLASH_ACCESS_KEY"] as? String {
            headers["Authorization"] = "Client-ID \(accessKey)"
        }
        
        return headers
    }
    
    var request: URLRequest {
        var components = URLComponents(string: self.baseURL + self.path)!
        components.queryItems = self.queryItems
        var request = URLRequest(url: components.url!)
        
        request.httpMethod = self.method.rawValue
        headers?.forEach({ key, value in
            request.addValue(value, forHTTPHeaderField: key)
        })
        return request
    }
}
