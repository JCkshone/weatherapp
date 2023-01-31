//
//  ForecastHome.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import SwiftUI

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
                        ForecastItem()
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
