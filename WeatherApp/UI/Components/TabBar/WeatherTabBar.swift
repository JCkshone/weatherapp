//
//  WeatherTabBar.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import SwiftUI

struct WeatherTabBar: View {
    let tabs: [WeatherTabBarItem]
    @Binding var tabSelected: WeatherTabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        print(tab)
                        switchToTap(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }
}

struct WeatherTabBar_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [WeatherTabBarItem] = [.searchCities, .myCities, .weather]
        VStack {
            Spacer()
            WeatherTabBar(
                tabs: tabs,
                tabSelected: .constant(tabs.first!)
            )
        }
    }
}

extension WeatherTabBar {
    private func tabView(tab: WeatherTabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text("\(tab.title) tab: \(tab.iconName), \(tabSelected.iconName)")
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(tabSelected == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(tabSelected == tab ? tab.color.opacity(0.2) : Color.clear )
        .cornerRadius(10)
    }
    
    func switchToTap(tab: WeatherTabBarItem) {
        withAnimation(.easeInOut) {
            tabSelected = tab
        }
    }
}
