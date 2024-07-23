//
//  ViewModel.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var isLoading = true
    
    
    @Published var weatherResponse: WeatherResponse? = nil
    @Published var weatherList: [WeatherResponse] = []
    @Published var cityList = [
        City(cityName: "Cairo", latitude: 30.033333, longitude: 31.233334, isLiked: false, temp: 0.0),
        City(cityName: "Tokyo", latitude: 35.652832, longitude: 139.839478, isLiked: false, temp: 0.0),
        City(cityName: "Madrid", latitude: 40.416775, longitude: -3.703790, isLiked: false, temp: 0.0),
        City(cityName: "Lagos", latitude: 40.416775, longitude: 3.406448, isLiked: false, temp: 0.0),
        City(cityName: "Moscow", latitude: 55.751244, longitude: 37.618423, isLiked: false, temp: 0.0),
    ]
    
    
    
    func fetchCityWeather(latitude: Double, longitude: Double) {
        isLoading = true
        NetworkService.fetchWeather(with: "\(latitude)", and: "\(longitude)") { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.weatherResponse = weather
                    self?.isLoading = false
                    print(self?.weatherResponse?.current.temperature_2m)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchCitiesWeather() {
        isLoading = true
        NetworkService.fetchWeathers{ [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.weatherList = weather
                    self?.updateCityTemperatures()
                    self?.isLoading = false
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func updateCityTemperatures() {
        for (index, city) in cityList.enumerated() {
            if let weather = weatherList.first(where: { Int($0.latitude) == Int(city.latitude) && Int($0.longitude) == Int(city.longitude) }) {
                cityList[index].updateTemp(temp: weather.current.temperature_2m)
                print(weather.current.temperature_2m)
                
            }
        }
    }

    
    
    
}
