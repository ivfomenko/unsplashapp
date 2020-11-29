//
//  DependenciesHolder.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 12.08.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Swinject

class DependenciesHolder {
    func injector() -> Container {
        let container = Container()
    
        // Register PhotoStore. New instance created on each 'resolve()'
        container.register(PhotoStore.self) { resolver -> PhotoStore in
            return PhotoStore(initialState: resolver.resolve(PhotosAppState.self)!, environment: resolver.resolve(PhotosServiceContainer.self)!)
        }.inObjectScope(.transient)
        
        // Register NetworkPhotoContentProvider. New instance created on each 'resolve()'
        container.register(NetworkPhotoContentProvider.self) { _ -> NetworkPhotoContentProvider in
            return NetworkPhotoContentProvider()
        }.inObjectScope(.transient)
        
        // Register DatabasePhotoContentProvider. New instance created on each 'resolve()'
        container.register(DatabasePhotoContentProvider.self) { resolver -> DatabasePhotoContentProvider in
            return DatabasePhotoContentProvider(storage: resolver.resolve(RealmStorageManager.self)!)
        }.inObjectScope(.transient)
        
        // Register PhotosAppState. New instance created on each 'resolve()'
        container.register(PhotosAppState.self) { _ -> PhotosAppState in
            return PhotosAppState()
        }.inObjectScope(.transient)
        
        // Register RealmStorageManager. New instance created on each 'resolve()'
        container.register(RealmStorageManager.self) { _ -> RealmStorageManager in
            return RealmStorageManager()
        }.inObjectScope(.transient)
        
        // Register PhotosServiceContainer. New instance created on each 'resolve()'
        container.register(PhotosServiceContainer.self) { resolver -> PhotosServiceContainer in
            return PhotosServiceContainer(
                photoContentProvider: resolver.resolve(NetworkPhotoContentProvider.self)!,
                databasePhotoProvider: resolver.resolve(DatabasePhotoContentProvider.self)!
            )
        }.inObjectScope(.transient)
        
        return container
    }
}
