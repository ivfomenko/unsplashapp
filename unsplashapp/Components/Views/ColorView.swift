//
//  ColorView.swift
//  unsplashapp
//
//  Created by Ivan Fomenko on 27.07.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//

import SwiftUI

struct ColorView: View {
    
    let color: UIColor
    let cornderRadius: CGFloat
    
    init(color: UIColor, cornderRadius: CGFloat = 0.0) {
        self.color = color
        self.cornderRadius = cornderRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: self.cornderRadius)
            .fill(Color(self.color))
    }
}
