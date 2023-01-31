//
//  ForecastHome.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import SwiftUI

struct ForecastItem: View {
    let info: ForecastToday
    
    var body: some View {
        VStack {
            WeatherText(
                text: info.time,
                style: (.title, .gray)
            )
            Image(uiImage: UIImage(named: info.icon) ?? UIImage())
                .resizable()
                .frame(width: 64, height:  64)
            WeatherText(
                text: info.temp,
                style: (.title, .dark)
            )
        }
    }
}

struct ForecastComponent: View {
    @Binding var forecasts: [ForecastToday]
    
    var body: some View {
        VStack {
            WeatherText(
                text: "today's forecast".uppercased(),
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.all, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(Array(forecasts.enumerated()), id: \.offset) { (position, item) in
                        ForecastItem(info: item)
                        if position < forecasts.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 16)
            
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .padding(.all)
    }
}

struct ForecastDay: View {
    let forecast: ForecastDayWithIcon
    
    var body: some View {
        HStack(alignment: .center) {
            WeatherText(
                text: forecast.day.capitalized,
                style: (.description, .gray),
                alignment: .leading
            )
            Image(uiImage: UIImage(named: forecast.icon) ?? UIImage())
                .resizable()
                .frame(width: 38, height:  38)
                .padding(.trailing, 16)
            
            WeatherText(
                text: forecast.weatherName,
                style: (.title, .dark)
            )

            HStack {
                WeatherText(
                    text: "\(forecast.temp)°",
                    style: (.title, .dark),
                    alignment: .trailing
                )
                WeatherText(
                    text: "/\(forecast.realTemp)°",
                    style: (.description, .gray),
                    alignment: .leading
                )
            }

        }
        .padding(.horizontal, 15)
        .frame(height: 30)
    }
}

struct ForecastWeek: View {
    let forecastDays: [ForecastDayWithIcon]
    var body: some View {
        VStack {
            WeatherText(
                text: "\(forecastDays.count)-day forecast".uppercased(),
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.horizontal)
            .padding(.top)
            
            ForEach(Array(forecastDays.enumerated()), id: \.offset) { (position, item) in
                if position < forecastDays.count - 1 {
                    ForecastDay(
                        forecast: item
                    )
                    Divider()
                        .padding(.horizontal)
                } else {
                    ForecastDay(
                        forecast: item
                    ).padding(.bottom, 12)
                }
            }
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .padding(.all)
    }
}
