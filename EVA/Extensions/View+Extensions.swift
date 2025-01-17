//
//  View+Extensions.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import Foundation
import SwiftUI

extension View{
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View{
        clipShape(RoundedCorner(radius: radius,corners: corners))
    }
}

struct RoundedCorner: Shape{
    var radius: CGFloat = .infinity
    var corners : UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
