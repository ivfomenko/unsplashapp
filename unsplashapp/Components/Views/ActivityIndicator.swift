//
//  ActivityIndicator.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 04.10.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - Base
struct ActivityIndicator: View {
    // - Init Propreties
    let style = StrokeStyle(lineWidth: 3.0, lineCap: .round)
    /// Start color for AngularGradient in spinner
    let color1: Color
    /// End color for AngularGradient in spinnner
    let color2: Color
    
    // - State propreties
    @State var animate = false
    
    // - Init
    init(color1: Color = .gray, color2: Color = Color.gray.opacity(0.5)) {
        self.color1 = color1
        self.color2 = color2
    }
    

}

// MARK: - Body
extension ActivityIndicator {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color1, color2]), center: .center), style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(
                    Animation.linear(duration: 0.7).repeatForever(autoreverses: false)
                )
        }.onAppear() {
            self.animate.toggle()
        }
    }
}
