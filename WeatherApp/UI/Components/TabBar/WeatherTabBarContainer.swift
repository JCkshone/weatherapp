//
//  WeatherTabBarContainer.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import SwiftUI

struct WeatherTabBarContainer<Content: View>: View {
    @Binding var selection: WeatherTabBarItem
    let content: Content
    @State private var tabs: [WeatherTabBarItem] = []
    
    
    init(selection: Binding<WeatherTabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                content
            }
            WeatherTabBar(tabs: tabs, tabSelected: $selection,
                          localSelection: selection)
        }
        .onPreferenceChange(WeatherTabBarItemsPreferenceKey.self) { tabs in
            self.tabs = tabs
        }
    }
}

struct WeatherTabBarContainer_Previews: PreviewProvider {
    static let tabs: [WeatherTabBarItem] = [ .weather, .myCities, .searchCities]
    static var previews: some View {
        WeatherTabBarContainer(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
