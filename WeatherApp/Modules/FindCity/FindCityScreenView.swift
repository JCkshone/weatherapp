//
//  FindCityScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import SwiftUI

struct FindCityScreenView: View {
    @State var searchValue: String = ""
    @StateObject private var viewModel = FindCityViewModel()

    var body: some View {
        ZStack {
            WeatherColor.background.color
                .ignoresSafeArea(.all)
            
            VStack {
                WeatherText(
                    text: "My Cities",
                    style: (.mediumTitle, .dark),
                    alignment: .leading
                )
                VStack {
                    TextField("Search for cities", text: $searchValue)
                        .foregroundColor(WeatherColor.gray.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                }
                .background(WeatherColor.section.color)
                .cornerRadius(12)
                
                ScrollView {
                    VStack {
                        ResultFindCity()
                        ResultFindCity()
                        ResultFindCity()
                    }
                }
                .padding(.top)
                .scrollDismissesKeyboard(.interactively)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct FindCityScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FindCityScreenView()
    }
}

struct ResultFindCity: View {
    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "Icon") ?? UIImage())
                .resizable()
                .frame(width: 48, height:  48)
                .padding(.all)
            
            VStack {
                WeatherText(
                    text: "Barcelona",
                    style: (.title, .dark),
                    alignment: .leading
                )
                WeatherText(
                    text: "10:23",
                    style: (.titleSection, .gray),
                    alignment: .leading
                )
            }
            WeatherText(
                text: "29°",
                style: (.mediumLightTitle, .gray),
                alignment: .trailing
            )
            .padding(.all)
            
        }
        .background(WeatherColor.section.color)
        .cornerRadius(16)
    }
}
