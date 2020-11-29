//
//  NetworkProvider.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 10.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Combine
import Foundation

/**
 Base Network Provider class.
 All Network Providers must be inherited from this class.
 
 - Contains private URLSession.shared.
 - Use request method for creating API request and parse needed response.
 */
class NetworkProvider {
    private let session = URLSession.shared
    
    func request<T: Decodable>(_ api: APIService, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return session.dataTaskPublisher(for: api.request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct Response<T: Decodable> {
    let value: T
    let response: URLResponse
}
