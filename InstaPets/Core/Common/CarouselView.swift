//
//  CarouselView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/02/23.
//

import SwiftUI
import Kingfisher
import ACarousel

struct CarouselView: View {
    var imgs: [URL]
    var index = 0
    
    var body: some View {
//        KFImage(URL(string: "https://picsum.photos/400/300")!)
        
        GeometryReader { geo in
            ACarousel(imgs,
                      id: \.self,
                      spacing: 0,
                      headspace: 0,
                      sidesScaling: 0.9,
                      isWrap: true
            ) { img in
                KFImage(img)
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
        CarouselView(imgs: Post.example.imageURLS)
    }
}
