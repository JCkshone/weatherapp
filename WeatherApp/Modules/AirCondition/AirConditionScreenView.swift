//
//  AirConditionScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 28/01/23.
//

import SwiftUI

struct AirConditionWithWeather {
    let title: String
    let icon: String
    let temp: String
    let uv: String
    let wind: String
    let humidity: String
    let feelsLike: String
    let visibility: String
    let pressure: String
}

struct AirConditionScreenView: View {
    let airCondition: AirConditionWithWeather
    
    @EnvironmentObject var coordinator: Coordinator<SplashRouter>

    var body: some View {
        ZStack {
            WeatherColor.background.color
                .ignoresSafeArea(.all)
            GeometryReader { proxy in
                VStack {
                    HStack(alignment: .center) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(WeatherColor.gray.color)
                            .onTapGesture {
                                coordinator.pop()
                            }
                        WeatherText(
                            text: "Air Conditions",
                            style: (.title, .gray)
                        )
                    }
                    .frame(height: 48)
                    .padding(.horizontal)
                    
                    ScrollView {
                        HeaderComponent(
                            title: airCondition.title,
                            temp: airCondition.temp,
                            icon: airCondition.icon
                        )
                            .padding(.top)
                        VStack {
                            ContentAirConditionInfo(
                                first: (
                                    title: "UV index",
                                    value: airCondition.uv
                                ),
                                second: (
                                    title: "Wind",
                                    value: airCondition.wind
                                )
                            )
                            ContentAirConditionInfo(
                                first: (
                                    title: "Humidity",
                                    value: airCondition.humidity
                                ),
                                second: (
                                    title: "Visibility",
                                    value: airCondition.visibility
                                )
                            )
                            ContentAirConditionInfo(
                                first: (
                                    title: "Feels like",
                                    value: airCondition.feelsLike
                                ),
                                second: (
                                    title: "Pressure",
                                    value: airCondition.pressure
                                )
                            )

                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .automatic)
    }
}

struct AirConditionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AirConditionScreenView(
            airCondition: AirConditionWithWeather(
                title: "",
                icon: "",
                temp: "",
                uv: "",
                wind: "",
                humidity: "",
                feelsLike: "",
                visibility: "",
                pressure: ""
            )
        )
    }
}

struct AirConditionInfoItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            WeatherText(
                text: title.uppercased(),
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.top, 12)
            
            WeatherText(
                text: value,
                style: (.semiMediumTitle, .dark),
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)

    }
}

struct ContentAirConditionInfo: View {
    let first: (title: String, value: String)
    let second: (title: String, value: String)
    
    var body: some View {
        HStack {
            AirConditionInfoItem(title: first.title, value: first.value)
            AirConditionInfoItem(title: second.title, value: second.value)
        }
    }
}
