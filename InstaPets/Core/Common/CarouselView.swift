//
//  CarouselView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/02/23.
//

import SwiftUI
import ACarousel

struct CarouselView: View {
    var imgs: [UIImage]
    
    var body: some View {
        GeometryReader { geo in
            ACarousel(imgs,
                      id: \.self,
                      spacing: 0,
                      headspace: 0,
                      sidesScaling: 0.9,
                      isWrap: true
            ) { img in
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 300)
            }
            .frame(width: geo.size.width, height: 300)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(imgs: Post.example.postImages!.map { $0.img })
    }
}
