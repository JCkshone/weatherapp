//
//  MyCitiesScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 28/01/23.
//

import SwiftUI
import CoreData

struct MyCitiesScreenView: View {
    @StateObject private var viewModel = MyCitiesViewModel()

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
                    TextField("Search for cities", text: $viewModel.searchValue)
                        .foregroundColor(WeatherColor.gray.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                }
                .background(WeatherColor.section.color)
                .cornerRadius(12)
                
                ScrollView {
                    LazyVStack(spacing: 6) {
                        ForEach(
                            Array(
                                ($viewModel.cities).enumerated()
                            ), id: \.offset
                        ) { (position, item) in
                            MyCityItem(info: item.wrappedValue) { itemForRemove in
                                viewModel.delete(entity: itemForRemove.entity)
                            } activeAction: { (lat, lon) in
                                viewModel.changeActivation(
                                    lat: lat,
                                    lon: lon
                                )
                            }
                        }
                    }
                }
                .padding(.top)
                .refreshable {
                    viewModel.loadCities()
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.viewDidLoad()
        }
    }
}

struct MyCitiesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyCitiesScreenView()
    }
}

struct MyCityItem: View {
    let info: MyCitiesItem
    let removeAction: (MyCitiesItem) -> Void
    let activeAction: (Double, Double) -> Void
    
    var body: some View {
        WeatherSwipeable(content: {
            ZStack {
                HStack(alignment: .center) {
                    WeatherText(
                        text: info.name,
                        style: (.semiMediumTitle, .dark),
                        alignment: .leading
                    )
                    
                    WeatherText(
                        text: info.temp,
                        style: (.largeTitleLight, .gray),
                        alignment: .trailing
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(WeatherColor.section.color)
                .cornerRadius(16)
                
                GeometryReader { proxy in
                    Image(systemName: info.isFirst ? "location.fill" : .empty)
                        .position(
                            x: proxy.frame(in: .global).maxX - 30,
                            y: proxy.frame(in: .local).minY + 20
                        )
                        .frame(width: 16, height: 16)
                        .foregroundColor(WeatherColor.blue.color)
                }
            }
        }, itemHeight: 84, canDelete: info.canDelete) {
            removeAction(info)
        }
        .onTapGesture {
            activeAction(info.lat, info.lon)
        }
    }
}
