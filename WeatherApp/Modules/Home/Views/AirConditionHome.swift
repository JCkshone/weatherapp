//
//  AirConditionHome.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import SwiftUI

struct AirConditions: View {
    let action: () -> Void

    var body: some View {
        VStack {
            HStack {
                WeatherText(
                    text: "Air conditions".uppercased(),
                    style: (.titleSection, .gray),
                    alignment: .leading
                )
                Spacer()
                Button(action: action) {
                    WeatherText(
                        text: "See more",
                        style: (.descriptionMedium, .section)
                    )
                    .padding(.vertical, 6)
                }
                .background(WeatherColor.blue.color)
                .frame(width: 100)
                .cornerRadius(16)
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            HStack {
                AirConditionItem()
                AirConditionItem()
            }
            Spacer()
                .frame(height: 10)
            HStack {
                AirConditionItem()
                AirConditionItem()
            }
            .padding(.bottom)
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .padding(.all)
    }
}

struct AirConditionItem: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "thermometer.low")
                    .foregroundColor(WeatherColor.gray.color)
                WeatherText(
                    text: "Real Feel",
                    style: (.description, .gray),
                    alignment: .leading
                )
            }
            .padding(.horizontal)
            WeatherText(
                text: "30°",
                style: (.title, .dark),
                alignment: .leading
            )
            .padding(.horizontal, 38)
        }
    }
}
