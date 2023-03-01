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
    let spacing: CGFloat?
    let headspace: CGFloat?
    let cornerRadius: CGFloat?
    
    init(imgs: [UIImage], spacing: CGFloat? = nil, headspace: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        self.imgs = imgs
        self.spacing = spacing
        self.headspace = headspace
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        if imgs.count <= 1 {
            Image(uiImage: imgs[0])
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth * 0.9, height: 300)
                .if((cornerRadius != nil), transform: {
                    $0.cornerRadius(cornerRadius!)
                })
        } else {
            ACarousel(imgs,
                      id: \.self,
                      spacing: spacing ?? 0.0,
                      headspace: 10,
                      sidesScaling: 0.9,
                      isWrap: true
            ) { img in
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.9, height: 300)
                    .if((cornerRadius != nil), transform: {
                        $0.cornerRadius(cornerRadius!)
                    })
            }
            .frame(width: UIScreen.screenWidth, height: 300)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(imgs: Post.example.postImages!.map { $0.img }, spacing: 10.0, headspace: 10, cornerRadius: 20)
    }
}
