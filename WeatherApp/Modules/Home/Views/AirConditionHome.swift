//
//  AirConditionHome.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import SwiftUI

struct AirConditions: View {
    let aircondition: ForecastCurrent?
    let action: () -> Void
    
    func convertToCelsius(_ value: Double) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }

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
                AirConditionItem(
                    icon: "thermometer.low",
                    title: "Real Feel",
                    value: self.convertToCelsius(aircondition?.feelsLike ?? .zero)
                )
                AirConditionItem(
                    icon: "wind",
                    title: "Wind",
                    value: "\(aircondition?.windSpeed ?? .zero) km/h"
                )
            }
            Spacer()
                .frame(height: 10)
            HStack {
                AirConditionItem(
                    icon: "humidity.fill",
                    title: "Chance of rain",
                    value: "\(aircondition?.humidity ?? .zero) %"
                )
                AirConditionItem(
                    icon: "sun.max.fill",
                    title: "UV Index",
                    value: "\(aircondition?.uvi ?? .zero)"
                )
            }
            .padding(.bottom)
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .padding(.all)
    }
}

struct AirConditionItem: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(WeatherColor.gray.color)
                WeatherText(
                    text: title,
                    style: (.description, .gray),
                    alignment: .leading
                )
            }
            .padding(.horizontal)
            WeatherText(
                text: value,//"30°",
                style: (.title, .dark),
                alignment: .leading
            )
            .padding(.horizontal, 38)
        }
    }
}
