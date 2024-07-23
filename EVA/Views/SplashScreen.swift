//
//  SplashScreen.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.7
    var body: some View {
        if isActive{
            CitiesScreen()
        } else {
            VStack{
                VStack{
                    Image("EVAPHARMA")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self .opacity = 1.0
                        }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ){
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
