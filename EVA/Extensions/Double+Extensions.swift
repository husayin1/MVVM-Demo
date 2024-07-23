//
//  Double+Extensions.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import Foundation

extension Double{
    func roundDouble() -> String{
        return String(format: "%0.f", self)
    }
}
