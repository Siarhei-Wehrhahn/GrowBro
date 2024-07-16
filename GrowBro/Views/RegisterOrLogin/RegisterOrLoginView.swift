//
//  RegisterOrLoginView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct RegisterOrLoginView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        if viewModel.showRegister {
            AuthenticationView()
                .environmentObject(viewModel)
        } else {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}


#Preview {
    RegisterOrLoginView()
}
