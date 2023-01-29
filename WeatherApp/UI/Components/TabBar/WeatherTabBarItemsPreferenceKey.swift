//
//  WeatherTabBarItemsPreferenceKey.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import SwiftUI

struct WeatherTabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [WeatherTabBarItem] = []
    
    static func reduce(value: inout [WeatherTabBarItem], nextValue: () -> [WeatherTabBarItem]) {
        value += nextValue()
    }
}

struct WeatherTabBarItemViewModifier: ViewModifier {
    let tab: WeatherTabBarItem
    @Binding var selection: WeatherTabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : .zero)
            .preference(key: WeatherTabBarItemsPreferenceKey.self, value: [tab])
    }
}


extension View {
    func tabBarItem(tab: WeatherTabBarItem, selection: Binding<WeatherTabBarItem>) -> some View {
        modifier(WeatherTabBarItemViewModifier(tab: tab, selection: selection))
    }
}
