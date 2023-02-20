//
//  RegistrationView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedSex: Sex = .female
    @State private var selectedPetType: PetType = .cat
    
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
                    .frame(height: 100)
                
                // Header
                Group {
                    Text("InstaPets").font(Font.custom("Pacifico-Regular", size: 70))
                    
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
                        .background(Color.theme.secondaryBackgroundColor)
                    
                    // Pet Name
                    TextField("Your Pet's Name", text: $fullname)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .regular))
                        .frame(height: 40)
                        .background(Color.theme.secondaryBackgroundColor)
                    
                    // User Name
                    TextField("Username", text: $username)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .regular))
                        .frame(height: 40)
                        .background(Color.theme.secondaryBackgroundColor)
                    
                    // Password
                    SecureField("Password", text: $password)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .regular))
                        .frame(height: 40)
                        .background(Color.theme.secondaryBackgroundColor)
                }
                .padding(.vertical, 1)
                .cornerRadius(7)
                
//                Picker("Sex", selection: $selectedSex) {
//                    ForEach(Sex.allCases) { sex in
//                        Text(sex.rawValue.capitalized)
//                    }
//                }.pickerStyle(WheelPickerStyle())
//
//                Picker("Pet Type", selection: $selectedPetType) {
//                    ForEach(PetType.allCases) { type in
//                        Text(type.rawValue.capitalized)
//                    }
//                }
                
                Spacer()
                
                Text("Sign Up 🐣")
                    .font(.system(size: 26, weight: .semibold))
                    .frame(maxWidth: Double.infinity)
                    .frame(height: 70)
                    .background(Color.theme.secondaryBackgroundColor)
                    .cornerRadius(7)
                
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
