//
//  FontDefinition.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

struct Rubik {
    static let regular = "Rubik-Regular"
    static let medium = "Rubik-Medium"
    static let semiBold = "Rubik-SemiBold"
}

enum FontDefinition {
    /// Large title - Semi bold 48
    case largeTitle
    
    /// Large title - Regular 48
    case largeTitleLight
    
    /// Large light title - Regular 24
    case mediumLightTitle
    
    /// Medium Title - Semi bold 32
    case mediumTitle
    
    /// Semi Medium Title - Semi bold 24
    case semiMediumTitle
    
    /// Title - Semi bold 16
    case title
    
    /// Title section - Semi bold 12
    case titleSection
    
    /// Description - Regular 16
    case description
    
    /// Description Medium - Medium 14
    case descriptionMedium
}

extension FontDefinition {
    var font: Font {
        switch self {
        case .largeTitle:
            return Font.custom(
                Rubik.semiBold,
                size: 48
            )
        case .largeTitleLight:
            return Font.custom(
                Rubik.regular,
                size: 48
            )
        case .mediumLightTitle:
            return Font.custom(
                Rubik.regular,
                size: 24
            )
        case .mediumTitle:
            return Font.custom(
                Rubik.semiBold,
                size: 32
            )
        case .semiMediumTitle:
            return Font.custom(
                Rubik.semiBold,
                size: 24
            )
        case .title:
            return Font.custom(
                Rubik.semiBold,
                size: 16
            )
        case .titleSection:
            return Font.custom(
                Rubik.semiBold,
                size: 12
            )
        case .description:
            return Font.custom(
                Rubik.regular,
                size: 16
            )
        case .descriptionMedium:
            return Font.custom(
                Rubik.medium,
                size: 14
            )
        }
    }
}
