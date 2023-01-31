//
//  AirConditionScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 28/01/23.
//

import SwiftUI

struct AirConditionScreenView: View {
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
                            title: "Air condition",
                            temp: "31"
                        )
                            .padding(.top)
                        VStack {
                            ContentAirConditionInfo()
                            ContentAirConditionInfo()
                            ContentAirConditionInfo()
                            ContentAirConditionInfo()
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
        AirConditionScreenView()
    }
}

struct AirConditionInfoItem: View {
    var body: some View {
        VStack {
            WeatherText(
                text: "UV index",
                style: (.titleSection, .gray),
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.top, 12)
            
            WeatherText(
                text: "3",
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
    var body: some View {
        HStack {
            AirConditionInfoItem()
            AirConditionInfoItem()
        }
    }
}
