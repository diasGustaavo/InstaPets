//
//  PostCommentsView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 22/03/23.
//

import SwiftUI

struct PostCommentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding(.vertical)
                        .foregroundColor(Color.theme.basicTextColor)
                }
                
                Spacer()
                
                Text("Comments")
                    .font(.system(size: 19, weight: .bold))
                
                Spacer()
                    .frame(width: UIScreen.screenWidth * 0.36)
            }
            .padding(.leading)
            
            Divider()
                .padding(.bottom)
            
            ScrollView {
                ForEach(1..<100) { index in
                    CommentView()
                }
            }
        }
    }
}

struct PostCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentsView()
    }
}

struct CommentView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(uiImage: UIImage(named: "clebinho1")!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth * 0.10, height: UIScreen.screenWidth * 0.10)
                .clipped()
                .cornerRadius(999)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("diasgustaavo")
                    .font(.system(size: 20, weight: .semibold))
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget nisi enim. In hac habitasse platea dictumst. Nunc ultrices congue orci, ac vulputate nunc. Quisque pulvinar mi id magna imperdiet euismod. Vivamus quis neque pretium, hendrerit enim ac, accumsan metus. Ut tempus, nisi sed consequat dignissim, elit risus tempus velit, nec sollicitudin metus libero et nulla. Fusce et ex ut sapien egestas finibus. Fusce ornare ex ac diam ornare mollis. Nullam pellentesque hendrerit lorem, eu pharetra enim scelerisque vitae. Mauris sit amet ultricies ante. Vivamus risus nisl, tincidunt vitae nibh vitae, finibus ultricies odio. Aliquam et cursus mauris. Curabitur mollis ipsum id sapien pharetra rhoncus.")
            }
            
            Spacer()
        }
        .padding(.trailing)
    }
}
