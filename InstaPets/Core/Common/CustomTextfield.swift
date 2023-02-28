//
//  CustomTextfield.swift
//  InstaPets
//
//  Created by Gustavo Dias on 25/02/23.
//

import SwiftUI

struct CustomTextfield: View {
    let width: CGFloat?
    let minRows: Int
    let maxRows: Int
    let placeholder: String
    let filled: Bool
    @State private var text: String = ""
    
    init(placeholder: String = "", width: CGFloat? = nil, minRows: Int = 1, maxRows: Int = 1, filled: Bool = false) {
        self.width = width
        self.minRows = minRows
        self.maxRows = maxRows
        self.placeholder = placeholder
        self.filled = filled
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if filled {
                    TextField("", text: $text, axis: .vertical)
                        .foregroundColor(Color.theme.secondaryForegroundColor)
                        .modifier(PlaceholderStyle(showPlaceHolder: text.isEmpty, placeholder: placeholder))
                        .padding(10)
                        .background(
                            Color.theme.foregroundColor
                                .cornerRadius(15)
                        )
                        .lineLimit( minRows...maxRows )
                } else {
                    TextField("", text: $text, axis: .vertical)
                        .foregroundColor(Color.theme.foregroundColor)
                        .modifier(PlaceholderStyle(showPlaceHolder: text.isEmpty, placeholder: placeholder))
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .stroke(Color.theme.foregroundColor, lineWidth: 2)
                        )
                        .lineLimit( minRows...maxRows )
                }
            }
            .frame(width: width ?? geo.size.width)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CustomTextfield_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextfield(placeholder: "Enter your text right here ;)", width: UIScreen.screenWidth - 20, minRows: 5, maxRows: 5, filled: true)
    }
}
