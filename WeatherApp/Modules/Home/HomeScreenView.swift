//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var coordinator: Coordinator<SplashRouter>

    var body: some View {
        ZStack {
            WeatherColor.background.color
                .ignoresSafeArea(.all)
            GeometryReader { proxy in
                TabView {
                    ScrollView {
                        HeaderComponent()
                        ForecastComponent()
                        AirConditions {
                            coordinator.show(.airCondition)
                        }
                        ForecastWeek()
                    }.tabItem {
                        Text("Funco")
                    }
                    MyCitiesScreenView().tabItem {
                        Text("Funco2")
                    }
                    FindCityScreenView().tabItem {
                        Text("Funco3")
                    }
                }
            }
        }
        .toolbar(.hidden, for: .automatic)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct HeaderComponent: View {
    var body: some View {
        VStack {
            WeatherText(
                text: "Madrid",
                style: (.mediumTitle, .dark)
            )
            WeatherText(
                text: "Chance of rain: 0%",
                style: (.description, .gray)
            )
            Image(uiImage: UIImage(named: "Icon") ?? UIImage())
                .resizable()
                .frame(width: 160, height:  160)
            WeatherText(
                text: "31°",
                style: (.largeTitle, .dark)
            )
        }
    }
}

struct ForecastItem: View {
    var body: some View {
        VStack {
            WeatherText(
                text: "9:00 AM",
                style: (.title, .gray)
            )
            Image(uiImage: UIImage(named: "Icon") ?? UIImage())
                .resizable()
                .frame(width: 64, height:  64)
            WeatherText(
                text: "31°",
                style: (.title, .dark)
            )
        }
    }
}

struct ForecastComponent: View {
    var body: some View {
        VStack {
            WeatherText(
                text: "today's forecast".uppercased(),
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.all, 16)
            ScrollView {
                HStack {
                    ForEach(0..<3) { position in
                        ForecastItem()
                        if position < 2 {
                            Divider()
                        }
                    }
                }
            }
            .padding(.bottom, 16)
            
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .padding(.all)
    }
}

struct ForecastDay: View {
    var body: some View {
        HStack(alignment: .center) {
            WeatherText(
                text: "Today",
                style: (.description, .gray),
                alignment: .leading
            )
            Image(uiImage: UIImage(named: "Icon") ?? UIImage())
                .resizable()
                .frame(width: 38, height:  38)
                .padding(.trailing, 16)
            
            WeatherText(
                text: "Sunny",
                style: (.title, .dark)
            )

            HStack {
                WeatherText(
                    text: "36",
                    style: (.title, .dark),
                    alignment: .trailing
                )
                WeatherText(
                    text: "/  22",
                    style: (.description, .gray),
                    alignment: .leading
                )
            }

        }
        .padding(.horizontal, 15)
        .frame(height: 30)
    }
}

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

struct ForecastWeek: View {
    var body: some View {
        VStack {
            WeatherText(
                text: "7-day forecast".uppercased(),
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.horizontal)
            .padding(.top)
            
            ForEach(0..<7) { position in
                
                if position < 6 {
                    ForecastDay()
                    Divider()
                        .padding(.horizontal)
                } else {
                    ForecastDay()
                        .padding(.bottom, 12)
                }
            }
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
