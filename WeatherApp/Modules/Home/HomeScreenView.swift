//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var coordinator: Coordinator<SplashRouter>
    @State var tabSelected: WeatherTabBarItem = .weather
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()

    var body: some View {
        ZStack {
            WeatherColor.background.color
                .ignoresSafeArea(.all)
            GeometryReader { proxy in
                WeatherTabBarContainer(selection: $tabSelected) {
                    ScrollView {
                        HeaderComponent(
                            title: viewModel.weatherInfo?.name ?? .empty,
                            temp: viewModel.temp
                        )
                        ForecastComponent(
                            forecasts: $viewModel.forecastToday
                        )
                        AirConditions {
                            coordinator.show(.airCondition)
                        }
                        ForecastWeek()
                    }.tabBarItem(
                        tab: .weather,
                        selection: $tabSelected
                    )
                    
                    MyCitiesScreenView()
                        .tabBarItem(
                            tab: .myCities,
                            selection: $tabSelected
                        )
                    FindCityScreenView()
                        .tabBarItem(
                            tab: .searchCities,
                            selection: $tabSelected
                        )
                }
            }

            if $viewModel.viewState.wrappedValue == .isLoading {
                ZStack {
                    WeatherColor.background.color
                        .ignoresSafeArea(.all).opacity(0.8)
                    ActivityIndicator()
                        .foregroundColor(WeatherColor.blue.color)
                }
            }
        }
        .toolbar(.hidden, for: .automatic)
        .onAppear {
            viewModel.viewDidLoad()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

struct HeaderComponent: View {
    let title: String
    let temp: String
    
    var body: some View {
        VStack {
            WeatherText(
                text: title,
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
                text: temp,
                style: (.largeTitle, .dark)
            )
        }
    }
}
