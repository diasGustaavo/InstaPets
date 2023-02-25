//
//  Color.swift
//  UberClone
//
//  Created by Gustavo Dias on 02/02/23.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let foregroundColor = Color("foregroundColor")
    let accentTextColor = Color("accentTextColor")
    let basicTextColor = Color("basicTextColor")
    let secondaryForegroundColor = Color("secondaryForegroundColor")
}
