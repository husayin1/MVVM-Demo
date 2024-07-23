//
//  NetworkService.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import Foundation

class NetworkService {
    
    private static let session = URLSession.shared
    
    static func fetchWeather(with lat: String, and lon: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m,relative_humidity_2m,is_day,rain,visibility") else {
            completion(.failure(WeatherError.invalidUrl))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(WeatherError.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    static func fetchWeathers(completion: @escaping (Result<[WeatherResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=30.0625,35.65,40.42,40.42,55.75&longitude=31.25,139.8125,-3.6999998,3.4099998,37.625&current=temperature_2m,relative_humidity_2m,is_day,rain,visibility") else {
            completion(.failure(WeatherError.invalidUrl))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(WeatherError.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode([WeatherResponse].self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

// MARK: - Errors

enum WeatherError: Error {
    case invalidUrl
    case invalidResponse
}
