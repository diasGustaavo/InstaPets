//
//  PlaceholderStyle.swift
//  InstaPets
//
//  Created by Gustavo Dias on 25/02/23.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color.gray)
            }
            content
        }
    }
}
