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
    @Namespace private var namespace
    @State var localSelection: WeatherTabBarItem
    
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
        .background(
            WeatherColor.section.color.ignoresSafeArea(
                edges: .bottom
            )
        )
    }
}

struct WeatherTabBar_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [WeatherTabBarItem] = [.searchCities, .myCities, .weather]
        VStack {
            Spacer()
            WeatherTabBar(
                tabs: tabs,
                tabSelected: .constant(tabs.first!),
                localSelection: tabs.first!
            )
        }
    }
}

extension WeatherTabBar {
    private func tabView(tab: WeatherTabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            if !tab.title.isEmpty {
                Text("\(tab.title)").font(
                    .system(
                        size: 10,
                        weight: .semibold,
                        design: .rounded
                    )
                )
            }
            
        }
        .foregroundColor(tabSelected == tab ? tab.color : Color.gray.opacity(0.8))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(tabSelected == tab ? tab.color.opacity(0.2) : Color.clear )
        .cornerRadius(10)
    }
    
    func switchToTap(tab: WeatherTabBarItem) {
        withAnimation(.easeInOut) {
            tabSelected = tab
        }
    }
}

extension WeatherTabBar {
    
    private func tabView2(tab: WeatherTabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTap(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
}
