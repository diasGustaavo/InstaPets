//
//  MockedCreatePostView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 25/02/23.
//

import SwiftUI

struct MockedCreatePostView: View {
    @State var mockedTextfieldInput = "Just hanging out with my bud :))"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                VStack {
                    MockedHeaderBarView()
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            CarouselView(imgs: [UIImage(named: "minismalistCat")!], spacing: 10.0, headspace: 10, cornerRadius: 15)
                                .frame(maxWidth: .infinity)
                                .frame(alignment: .center)
                            
                            Text("1 image selected.")
                                .font(.system(.caption))
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .frame(alignment: .center)
                                .foregroundColor(Color.theme.foregroundColor)
                            
                            Spacer()
                                .frame(height: 25)
                            
                            Text("Description")
                                .font(.system(size: 25, weight: .semibold))
                                .padding(.horizontal)
                                .foregroundColor(Color.theme.foregroundColor)
                            
                            CustomTextfield(minRows: 5, maxRows: 5, placeholder: "Type your description right here.", filled: true, text: $mockedTextfieldInput)
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .transition(.move(edge: .bottom))
            
    }
}

struct MockedCreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(viewModel: PostModelView())
            .environmentObject(AuthViewModel())
            .environmentObject(HomeViewModel())
    }
}

//MARK: - HeaderBarView

struct MockedHeaderBarView: View {
    var body: some View {
        HStack {
            Text("🐈 New Post")
                .font(.system(size: 40, weight: .semibold))
                .padding(.horizontal)
                .foregroundColor(Color.theme.foregroundColor)
            
            Spacer()
            
            Button {
                // some action
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.theme.foregroundColor)
                    .font(.system(size: 30, weight: .semibold))
            }
        }
        .padding(.trailing)
    }
}
