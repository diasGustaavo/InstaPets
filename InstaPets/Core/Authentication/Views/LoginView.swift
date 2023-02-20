//
//  LoginView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                // Back Button
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding(.vertical)
                        .foregroundColor(Color.theme.primaryTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                    .frame(height: 150)
                
                // Header
                Text("InstaPets").font(Font.custom("Pacifico-Regular", size: 50))
                
                Spacer()
                    .frame(height: 50)
                
                Group {
                    // Email Field
                    TextField("Username", text: $username)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .regular))
                        .frame(height: 40)
                        .background(Color.theme.bwBackgroundColor)
                    
                    // Password
                    SecureField("Password", text: $password)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .regular))
                        .frame(height: 40)
                        .background(Color.theme.bwBackgroundColor)
                    
                    Text("Forgot Password?")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryBackgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 1)
                .cornerRadius(7)
                
                Spacer()
                
                Text("Log In 🐢")
                    .font(.system(size: 26, weight: .semibold))
                    .frame(maxWidth: Double.infinity)
                    .frame(height: 50)
                    .background(Color.theme.secondaryBackgroundColor)
                    .cornerRadius(7)
                
                Divider()
                    .padding(.vertical, 20)
                
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Text("Sign Up.")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.secondaryBackgroundColor)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
