//
//  CityWeather.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI

struct CityWeather: View {
    @StateObject var viewModel = WeatherViewModel()
    var city: City
    var delegate: CityCardDelegate?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Image("\(city.cityName)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height  + 200 )
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        VStack(alignment: .leading){
                            Text(city.cityName)
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("Today \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.light)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            delegate?.didLikeCity(city)
                        } label: {
                                Image(systemName: city.isLiked ? "suit.heart.fill" : "suit.heart")
                                    .font(.system(size: 24))
                                    .foregroundColor(city.isLiked ? .red : .gray)
                        }

                    }
                }
                .padding()
                .background(Color.black.opacity(0.6).cornerRadius(15))
                .padding(.horizontal)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Now")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Temperature", value: (viewModel.weatherResponse?.current.temperature_2m.roundDouble() ?? "0") + "\(viewModel.weatherResponse?.current_units.temperature_2m ?? "°C")")
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (viewModel.weatherResponse?.current.relative_humidity_2m.roundDouble() ?? "0") + "\(viewModel.weatherResponse?.current_units.relative_humidity_2m ?? "%")")
                    }
                    
                    HStack {
                        WeatherRow(logo: "eye", name: "Visibility", value: (viewModel.weatherResponse?.current.visibility.roundDouble() ?? "0") + "\(viewModel.weatherResponse?.current_units.visibility ?? " km")")
                        Spacer()
                        WeatherRow(logo: "cloud.rain", name: "Rain", value: (viewModel.weatherResponse?.current.rain.roundDouble() ?? "0") + "\(viewModel.weatherResponse?.current_units.rain ?? " mm")")
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .foregroundColor(.white)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            if viewModel.isLoading {
                VStack {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchCityWeather(latitude: city.latitude, longitude: city.longitude)
        }
    }
}

struct CityWeather_Previews: PreviewProvider {
    static var previews: some View {
        CityWeather(city: City(cityName: "Cairo", latitude: 35.248, longitude: 145.1), delegate: self as! CityCardDelegate)
    }
}
