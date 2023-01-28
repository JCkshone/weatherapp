//
//  ColorDefinition.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

enum WeatherColor: String {
    
    /// Primary - #F5F5F5
    case background = "#F5F5F5"
    
    /// Section - #EAECEF
    case section = "#EAECEF"
    
    /// Dark - #202B3B
    case dark = "#202B3B"
    
    /// Gray - #9399A2
    case gray = "#9399A2"
    
    /// Blue - #0095FF
    case blue = "#0095FF"
    
    /// Dangerous - #FA5C43
    case dangerous = "#FA5C43"
}

extension WeatherColor {
    var color: Color {
        Color(
            uiColor: self.rawValue.replacingOccurrences(of: " ", with: "").color
        )
    }
}
