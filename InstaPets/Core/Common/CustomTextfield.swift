//
//  CustomTextfield.swift
//  InstaPets
//
//  Created by Gustavo Dias on 25/02/23.
//

import SwiftUI

struct CustomTextfield: View {
    var width: CGFloat? = nil
    var minRows: Int = 1
    var maxRows: Int = 1
    var placeholder: String = ""
    var filled: Bool = false
    @Binding var text: String
    
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
    static var text: String = "teste"
    
    static var previews: some View {
        CustomTextfield(width: UIScreen.screenWidth - 20, minRows: 5, maxRows: 5, placeholder: "Enter your text right here ;)", filled: true, text: .constant("10"))
    }
}
