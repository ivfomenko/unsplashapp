//
//  Store.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import Foundation
import Combine

// MARK: - Store
class Store: ObservableObject {
    
    var effectCancellables: Set<AnyCancellable> = []
    
    // - Private Properties for redux container
    @Published private var state: AppState
    private let environment: ServiceContainer
    
    // - Init
    init(initialState: AppState, environment: ServiceContainer) {
        self.state = initialState
        self.environment = environment
    }

    // - Private logic for redux container
    func send(_ action: AppAction) {
        let effect = self.appReducer(state: &state, action: action, environment: environment)
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &effectCancellables)
    }
    
    func appReducer(state: inout AppState, action: AppAction, environment: ServiceContainer) -> AnyPublisher<AppAction, Never> {
        return Empty().eraseToAnyPublisher()
    }
}

// MARK: - ServiceContainer
class ServiceContainer { }

// MARK: - AppState
class AppState: ObservableObject { }
