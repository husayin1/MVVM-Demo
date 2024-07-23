//
//  CitiesScreen.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI

struct CitiesScreen: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Fetching Data...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        ForEach(viewModel.cityList) { city in
                            NavigationLink(destination: CityWeather(city: city, delegate: self)) {
                                CityCard(city: city)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(
                                        Color.white.opacity(0.6)
                                            .cornerRadius(12)
                                            .shadow(radius: 3)
                                    )
                                    .padding(.horizontal, 8)
                                    .animation(.easeInOut(duration: 0.3), value: city)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cities")
            
            .onAppear {
                viewModel.fetchCitiesWeather()
            }
        }
    }
    
    @ViewBuilder
    func CityCard(city: City) -> some View {
        HStack {
            Image("\(city.cityName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(city.cityName)
                    .fontWeight(.semibold)
                    .font(.title2)
                Text("\(String(format: "%.1f", city.temp ?? 0.0)) °C")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                didLikeCity(city)
            }) {
                Image(systemName: city.isLiked ? "suit.heart.fill" : "suit.heart")
                    .font(.system(size: 24))
                    .foregroundColor(city.isLiked ? .red : .gray)
            }
        }
        .padding()
    }
}

protocol CityCardDelegate: Any {
    func didLikeCity(_ city: City)
}

extension CitiesScreen: CityCardDelegate {
    func didLikeCity(_ city: City) {
        if let index = viewModel.cityList.firstIndex(where: { $0.id == city.id }) {
            viewModel.cityList[index].isLiked.toggle()
        }
    }
}

struct CitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CitiesScreen()
    }
}

