//
//  SplashScreenView.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI
import Foundation
import MapKit

struct SplashScreenView: View {
    @EnvironmentObject var coordinator: Coordinator<SplashRouter>
    @ObservedObject var viewModel: SplashViewModel = SplashViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                WeatherColor.background.color
                    .ignoresSafeArea(.all)
                VStack {
                    Image(
                        uiImage: UIImage(named: "Icon") ?? UIImage()
                    )
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 200)
                    WeatherText(
                        text: "Weather",
                        style: (.largeTitle, .dark)
                    )
                    WeatherText(
                        text: "App",
                        style: (.mediumLightTitle, .gray)
                    )
                    Spacer().frame(maxHeight: 70)
                    Button {
                        coordinator.show(.home)
                    } label: {
                        Image(
                            systemName: "arrow.right"
                        )
                        .foregroundColor(
                            WeatherColor.background.color
                        )
                        .frame(
                            width: 47,
                            height: 47
                        )
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(WeatherColor.blue.color)
                            .shadow(
                                color: .gray.opacity(0.7),
                                radius: 2,
                                x: 0, y: 2
                            )
                    )
                }
            }
            .toolbar(.hidden, for: .automatic)
            .onAppear {
                viewModel.viewDidLoad()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    
    static var previews: some View {

        SplashScreenView()
            .environmentObject(
                Coordinator<SplashRouter>.init(startingRoute: .splash)
            )
    }
}
