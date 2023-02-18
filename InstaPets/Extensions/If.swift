//
//  if.swift
//  InstaPets
//
//  Created by Gustavo Dias on 18/02/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool, transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
