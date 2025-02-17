//
//  GrowBroApp.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI
import FirebaseCore

@main
struct GrowBroApp: App {
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if viewRouter.currentPage == .splash {
                    SplashView()
                        .preferredColorScheme(.light) // Deaktiviere den Dark Mode
                        .onAppear {
                            // Nach 2 sek den viewRouter auf HomeView setzen
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewRouter.currentPage = .home
                                }
                            }
                        }
                } else if authenticationViewModel.userIsLoggedIn {
                    ChatView()
                        .environmentObject(authenticationViewModel)
                } else {
                    RegisterOrLoginView()
                        .environmentObject(authenticationViewModel)
                        .preferredColorScheme(.light)
                }
            }
        }
    }
}
