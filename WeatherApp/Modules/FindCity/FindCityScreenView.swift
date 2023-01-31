//
//  FindCityScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import SwiftUI


struct FindCityScreenView: View {
    @StateObject private var viewModel = FindCityViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            WeatherColor.background.color
                .ignoresSafeArea(.all)
            
            VStack {
                WeatherText(
                    text: "Search City",
                    style: (.mediumTitle, .dark),
                    alignment: .leading
                )
                
                HStack {
                    TextField("Search for cities", text: $viewModel.searchValue)
                        .foregroundColor(WeatherColor.gray.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .autocorrectionDisabled()
                        .focused($isFocused)
                    Button {
                        viewModel.searchExecution()
                        isFocused = false
                    } label: {
                        WeatherText(
                            text: "Search",
                            style: (.descriptionMedium, .blue)
                        )
                    }
                    .frame(width: 50)
                    .padding(.trailing)
                    
                }
                .background(WeatherColor.section.color)
                .cornerRadius(12)
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(
                            Array(
                                (viewModel.response?.list ?? []).enumerated()
                            ), id: \.offset
                        ) { (position, item) in
                            ResultFindCity(
                                info: item
                            ) { itemSelect in
                                viewModel.saveCity(with: itemSelect)
                            }
                        }
                    }
                    if $viewModel.response.wrappedValue == nil {
                        WeatherText(
                            text: "Search and select your favorite cities",
                            style: (.mediumLightTitle, .gray)
                        )
                        .opacity(0.5)
                    }
                }
                .padding(.top)
                .scrollDismissesKeyboard(.interactively)
                
                Spacer()
            }
            .padding(.horizontal)
            
            if $viewModel.viewState.wrappedValue == .isLoading {
                ZStack {
                    WeatherColor.background.color
                        .ignoresSafeArea(.all).opacity(0.8)
                    ActivityIndicator()
                        .foregroundColor(WeatherColor.blue.color)
                }
            }
        }
        .alert(
            "Your select city was saved",
            isPresented: $viewModel.showConfirmation
        ) {
            Button("OK", role: .cancel) { }
        }
        .onAppear{
            viewModel.viewDidLoad()
        }
    }
}

struct FindCityScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FindCityScreenView()
    }
}

struct ResultFindCity: View {
    let info: WeatherResult
    var action: (WeatherResult) -> Void
    var body: some View {
        HStack {
            Image(uiImage:
                    UIImage(
                        named: loadIcon(weathers: info.weather)
                    ) ?? UIImage())
            .resizable()
            .frame(width: 48, height:  48)
            .padding(.all)
            
            VStack {
                WeatherText(
                    text: "\(info.name), \(info.sys.country)",
                    style: (.title, .dark),
                    alignment: .leading
                )
                WeatherText(
                    text: "\(info.dt)".getTime(),
                    style: (.titleSection, .gray),
                    alignment: .leading
                )
            }
            WeatherText(
                text: self.convertToCelsius(info.main.temp),
                style: (.mediumLightTitle, .gray),
                alignment: .trailing
            )
            .padding(.all)
            
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
        .onTapGesture {
            action(info)
        }
    }
}
