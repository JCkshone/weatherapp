//
//  WeatherText.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

struct WeatherText: View {
    let text: String
    let style: (FontDefinition, WeatherColor)
    var alignment: Alignment = .center
    
    var body: some View {
        Text(text)
            .font(style.0.font)
            .foregroundColor(style.1.color)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct WeatherText_Previews: PreviewProvider {
    static var previews: some View {
        WeatherText(
            text: "Breeze",
            style: (.largeTitle, .dark))
    }
}
