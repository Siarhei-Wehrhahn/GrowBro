//
//  LoginView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.7), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Grow Bro")
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                        .shadow(radius: 1)
                    
                    TextField("E-Mail", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none) // automatische Großschreibung aus
                    
                    SecureField("Passwort", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button  {
                        viewModel.login()
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding()
                    
                    Button  {
                        viewModel.showRegister = true
                    } label: {
                        Text("Registrieren")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                    Button {
                        viewModel.createAnonym()
                    } label: {
                        Text("Ohne Account fortfahren")
                            .foregroundStyle(.blue)
                            .padding()
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Anmeldedaten falsch!"), message: Text("Die E-Mail adresse oder das passwort ist leider falsch."), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationViewModel())
}
