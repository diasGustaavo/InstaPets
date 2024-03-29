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
    let slideScaling: CGFloat?
    let width: CGFloat
    
    init(imgs: [UIImage], spacing: CGFloat? = nil, headspace: CGFloat? = nil, cornerRadius: CGFloat? = nil, slideScaling: CGFloat? = nil, width: CGFloat? = 0.9) {
        self.imgs = imgs
        self.spacing = spacing
        self.headspace = headspace
        self.cornerRadius = cornerRadius
        self.slideScaling = slideScaling
        self.width = width ?? 0.9
    }
    
    var body: some View {
        if imgs.count <= 0 {
            Image(uiImage: UIImage(named: "minismalistCat")!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth * width, height: 300)
                .if((cornerRadius != nil), transform: {
                    $0.cornerRadius(cornerRadius!)
                })
        }
        else if imgs.count == 1 {
            Image(uiImage: imgs[0])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.screenWidth * width, height: 300)
                .clipped()
                .if((cornerRadius != nil), transform: {
                    $0.cornerRadius(cornerRadius!)
                })

        } else {
            ACarousel(imgs,
                      id: \.self,
                      spacing: spacing ?? 0.0,
                      headspace: headspace ?? 10,
                      sidesScaling: slideScaling ?? 0.9,
                      isWrap: true
            ) { img in
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * width, height: 300)
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
        CarouselView(imgs: CarouselView.mockImages, spacing: 10.0, headspace: 10, cornerRadius: 20)
    }
}

extension CarouselView {
    static let mockImages = [
        UIImage(named: "clebinho1")!,
        UIImage(named: "clebinho2")!,
        UIImage(named: "charlottinha")!
    ]
}
