//
//  RegistrationView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedPetType: PetType = .cat
    
    var body: some View {
        NavigationStack {
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
                            .foregroundColor(Color.theme.basicTextColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 100)
                    
                    // Header
                    Group {
                        Text("InstaPets").font(Font.custom("Pacifico-Regular", size: 70))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Text("Sign up to see & post photos of your favorite pets 🐱")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Group {
                        // Email Field
                        TextField("Email", text: $email)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                        
                        // Pet Name
                        TextField("Your Pet's Name", text: $fullname)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                        
                        // User Name
                        TextField("Username", text: $username)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                        
                        // Password
                        SecureField("Password", text: $password)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .regular))
                            .frame(height: 40)
                    }
                    .padding(.vertical, 1)
                    .cornerRadius(7)
                    
                    Spacer()
                    
                    NavigationLink {
                        AnimalTypeView(email: email, fullname: fullname, username: username, password: password)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Sign Up 🐣")
                            .font(.system(size: 26, weight: .semibold))
                            .frame(maxWidth: Double.infinity)
                            .frame(height: 70)
                            .foregroundColor(Color.theme.accentTextColor)
                            .background(Color.theme.foregroundColor)
                            .cornerRadius(7)
                    }
                    
                    Text("By signing up, you agree to our Terms, Data Policy and Cookies Policy.")
                        .font(.system(size: 12, weight: .semibold))
                        .frame(maxWidth: Double.infinity)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                        .frame(height: 50)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
