//
//  LazyView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 16/03/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}
