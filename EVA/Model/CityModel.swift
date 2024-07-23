//
//  CityModel.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import Foundation

struct City: Identifiable, Equatable{
    var id = UUID().uuidString
    let cityName: String
    let latitude: Double
    let longitude: Double
    var isLiked: Bool = false
    var temp: Double?
    
    mutating func updateTemp(temp:Double){
        self.temp = temp
    }
}

