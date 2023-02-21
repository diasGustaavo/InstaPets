//
//  AnimalTypeView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import SwiftUI

struct AnimalTypeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    let email: String
    let fullname: String
    let username: String
    let password: String
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
                        .foregroundColor(Color.theme.basicTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                    .frame(height: 100)
                
                // Header
                Text("What kind of animal is your little pet?")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color.theme.foregroundColor)
                
                Picker("Pet Type", selection: $selectedPetType) {
                    ForEach(PetType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Button {
                    viewModel.registerUser(fullPetName: fullname, username: username, withEmail: email, type: selectedPetType, withPassword: password)
                } label: {
                    Text("Continue 🐊")
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

struct AnimalTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalTypeView(email: "test@test.com", fullname: "talking parrot da silva", username: "talkingparrot", password: "12345678")
            .environmentObject(AuthViewModel())
    }
}
