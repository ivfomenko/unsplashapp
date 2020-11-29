//
//  APITarget.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 11.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

protocol APITarget {
    /**
     Base url for your API.
     - Example: https://yourappiAddress
     */
    var baseURL: String { get }
    
    /**
     Detailed path for your end point.
     - Example: /your path
     */
    var path: String { get }
    
    /**
     Request body should generated automaticly based on another params
     */
    var request: URLRequest { get }
    
    /**
     Headers for your request. Place authorization and language settings here
     */
    var headers: [String: String]? { get }
    /**
     HTTP method for your request. Look into HTTPMethod enum for details
     */
    var method: HTTPMethod { get }
    
    /**
     Additional Query params for your request. If your endpoint doesn't need any params, just add empty array, during genration of request param it should ignore this field.
     */
    var queryItems: [URLQueryItem] { get }
}
