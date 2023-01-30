//
//  Store.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import Combine

/// - Definitions

protocol Action { }
protocol ReduxState { }

/// Alias

typealias Dispatcher = (Action) -> Void
typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

/// - Store

class Store<StoreState: ReduxState>: ObservableObject {
    
    var reducer: Reducer<StoreState>
    var middlewares: [Middleware<StoreState>]
    
    @Published var state: StoreState
    
    init(
        reducer: @escaping Reducer<StoreState>,
        state: StoreState,
        middlewares: [Middleware<StoreState>] = []
    ) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(
        action: Action
    ) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
    
}
