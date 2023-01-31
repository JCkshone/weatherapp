//
//  Router.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 25/01/23.
//

import SwiftUI

public protocol Router {
    associatedtype DefinitionView: View
    
    var transition: NavigationType { get }
    
    @ViewBuilder
    func view() -> DefinitionView
}
