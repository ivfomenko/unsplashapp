//
//  Extensions.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 12.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation

// MARK: - URLQueryItem
extension URLQueryItem {
    static func initFrom(model: Codable) -> [URLQueryItem] {
        let items = model.dictionary.compactMap { URLQueryItem(name: $0, value: "\($1)") }
        return items
    }
}

// MARK: - Encodable
extension Encodable {
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
}

// MARK: - Collection
extension Collection {
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        return Array(self.enumerated())
    }
}
