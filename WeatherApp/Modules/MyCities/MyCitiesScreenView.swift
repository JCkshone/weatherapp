//
//  MyCitiesScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 28/01/23.
//

import SwiftUI

struct MyCitiesScreenView: View {
    @State var searchValue: String = ""
    
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
                        MyCityItem()
                        MyCityItem()
                        MyCityItem()
                        MyCityItem()
                    }
                }
                .padding(.top)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct MyCitiesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyCitiesScreenView()
    }
}

struct MyCityItem: View {
    var body: some View {
        WeatherSwipeable(content: {
            HStack {
                VStack {
                    HStack {
                        GeometryReader { proxy in
                            WeatherText(
                                text: "Madrid",
                                style: (.semiMediumTitle, .dark),
                                alignment: .leading
                            )
                            
                            Image(systemName: "location.fill")
                                .position(
                                    x: proxy.frame(in: .global).midX - 15,
                                    y: proxy.frame(in: .local).maxY - 21
                                )
                                .frame(width: 16, height: 16)
                                .foregroundColor(WeatherColor.dark.color)
                        }
                    }
                    
                    WeatherText(
                        text: "10:23",
                        style: (.titleSection, .gray),
                        alignment: .leading
                    )
                }
                WeatherText(
                    text: "31°",
                    style: (.largeTitleLight, .gray),
                    alignment: .trailing
                )
            }
            .padding(.all)
            .background(WeatherColor.section.color)
            .cornerRadius(16)
        }, itemHeight: 84)
    }
}
