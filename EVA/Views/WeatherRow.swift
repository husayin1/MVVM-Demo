//
//  WeatherRow.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title)
                .frame(width: 20,height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.546))
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 8){
                Text(name)
                    .font(.caption)
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}
