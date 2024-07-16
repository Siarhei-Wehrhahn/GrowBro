//
//  ChatView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    
    // Variable für die letzte gesendete Nachricht und Zeitstempel
    @State private var lastSentMessage: String?
    @State private var lastSentTimestamp = Date()
    
    var body: some View {
        ZStack {
            VStack {
                // Kopfzeile
                HStack {
                    Text("GrowBro Chat")
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        if authViewModel.user?.userName != "Anonym" {
                            authViewModel.logout()
                        } else {
                            authViewModel.deleteAccount()
                            authViewModel.logout()
                        }
                    }) {
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
                .padding()
                
                if viewModel.chatMessages.isEmpty {
                    Text("Hey, ich bin dein Grow Bro und stehe dir jederzeit zur Seite. Wenn du Fragen zu deinem Grow hast, zöger nicht, mich zu fragen!")
                        .offset(CGSize(width: 0.0, height: 200.0))
                        .bold()
                        .padding(13)
                }
                
                // Chat-Ansicht mit Texteingabe
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.chatMessages) { message in
                                ChatBubble(content: message.content, isUser: message.isUser)
                            }
                            
                            if viewModel.isLoading {
                                ChatBubble(content: nil, isUser: false, isLoading: true)
                                    .padding(.top, 10)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                    
                    Divider()
                    
                    // Texteingabe mit Senden-Button
                    HStack {
                        TextField("Nachricht eingeben", text: $viewModel.userInput, onCommit: {
                            sendMessage()
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.gray, lineWidth: 1)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        )
                        .padding(.trailing, 10)
                        
                        Button(action: {
                            sendMessage()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(Font.system(size: 25))
                                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(13)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Fehlende Informationen"),
                message: Text("Bitte geben Sie einen Text ein."),
                dismissButton: .default(Text("OK!"))
            )
        }
    }
    
    // Funktion zum Senden der Nachricht
    private func sendMessage() {
        guard !viewModel.userInput.isEmpty else {
            viewModel.showAlert.toggle()
            return
        }
        
        let currentTimestamp = Date()
        
        // Überprüfe, ob die Nachricht identisch mit der letzten ist und ob weniger als 3 Sekunden vergangen sind
        if viewModel.userInput == lastSentMessage && currentTimestamp.timeIntervalSince(lastSentTimestamp) < 3 {
            // Zeige eine Meldung an, dass die Nachricht nicht gesendet werden kann
            viewModel.showAlert.toggle()
            return
        }
        
        // Sende die Nachricht und aktualisiere die letzten Nachricht und den Zeitstempel
        viewModel.sendMessage()
        lastSentMessage = viewModel.userInput
        lastSentTimestamp = currentTimestamp
    }
}


#Preview {
    ChatView()
        .environmentObject(AuthenticationViewModel())
}
