//
//  feedPostView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/03/23.
//

import SwiftUI

struct feedPostView: View {
    static let mockImages = [
        UIImage(named: "clebinho1")!,
        UIImage(named: "clebinho2")!,
        UIImage(named: "charlottinha")!
    ]
    
    var body: some View {
        VStack() {
            HStack(spacing: 0) {
                Image(uiImage: UIImage(named: "clebinho1")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.10, height: UIScreen.screenWidth * 0.10)
                    .clipped()
                    .cornerRadius(999)
                    .padding(.horizontal)
                
                Text("diasgustaavo")
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
            }
            
            CarouselView(imgs: feedPostView.mockImages, spacing: 0, headspace: 0, slideScaling: 1.0, width: 1.0)
                .frame(maxWidth: .infinity)
                .frame(alignment: .center)
            
            HStack {
                Group {
                    Image(systemName: "heart")
                        .padding(.trailing, 2)
                    Image(systemName: "bubble.left")
                }
                .font(.system(size: 28))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 6)
            
            HStack {
                Text("474 likes")
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 6)
            
            HStack {
                Text("**diasGustaavo** Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt arcu in ante blandit, sit amet placerat neque ornare. Phasellus sed quam commodo, porta nisi id, efficitur tortor. Suspendisse hendrerit magna lectus, at hendrerit justo egestas vel. Curabitur fermentum diam eu urna maximus accumsan. Ut gravida eu lectus sed ullamcorper. Vestibulum vel lobortis sem. Curabitur dapibus aliquam placerat. Morbi ut pellentesque purus. Nullam pharetra tortor vitae sodales laoreet.")
                    .font(.system(size: 20, weight: .regular))
                    .lineLimit(3)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("View complete post")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.gray.opacity(0.9))
                    .lineLimit(3)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                Image(uiImage: UIImage(named: "clebinho1")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.08, height: UIScreen.screenWidth * 0.08)
                    .clipped()
                    .cornerRadius(999)
                    .padding(.horizontal)
                
                Text("Add a comment...")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.gray.opacity(0.9))
                
                Spacer()
            }
            
            HStack {
                Text("42 minutes ago")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.gray.opacity(0.9))
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct feedPostView_Previews: PreviewProvider {
    static var previews: some View {
        feedPostView()
    }
}
