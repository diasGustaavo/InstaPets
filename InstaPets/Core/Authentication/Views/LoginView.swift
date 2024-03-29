//
//  LoginView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: 150)
                    
                    // Header
                    Text("InstaPets").font(Font.custom("Pacifico-Regular", size: 50))
                        .foregroundColor(Color.theme.foregroundColor)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Group {
                        // Email Field
                        TextField("Email", text: $email)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                        
                        // Password
                        SecureField("Password", text: $password)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                        
                        Text("Forgot Password?")
                            .font(.caption)
                            .foregroundColor(Color.theme.foregroundColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.vertical, 1)
                    .cornerRadius(7)
                    
                    Spacer()
                    
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        Text("Log In 🐢")
                            .font(.system(size: 26, weight: .semibold))
                            .frame(maxWidth: Double.infinity)
                            .frame(height: 50)
                            .foregroundColor(Color.theme.accentTextColor)
                            .background(Color.theme.foregroundColor)
                            .cornerRadius(7)
                    }

                    
                    Divider()
                        .padding(.vertical, 20)
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.theme.basicTextColor)
                            
                            Text("Sign Up.")
                                .font(.system(size: 14, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.theme.foregroundColor)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
