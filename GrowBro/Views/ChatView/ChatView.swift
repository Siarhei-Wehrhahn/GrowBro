//
//  ChatView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.messages.isEmpty {
                    Text("Hey, ich bin dein Grow Bro und stehe dir jederzeit zur Seite. Wenn du Fragen zu deinem Grow hast, zöger nicht, mich zu fragen!")
                        .offset(CGSize(width: 0.0, height: 300.0))
                        .bold()
                        .padding(13)
                }
                
                // Chat-Ansicht mit Texteingabe
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.messages.indices, id: \.self) { index in
                                if index < viewModel.userMessages.count {
                                    ChatBubble(content: viewModel.messages[index], isUser: false)
                                    ChatBubble(content: viewModel.userMessages[index], isUser: true)
                                } else {
                                    ChatBubble(content: viewModel.messages[index], isUser: false)
                                }
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                    
                    Divider()
                    
                    // Texteingabe mit Senden-Button
                    HStack {
                        TextField("Nachricht eingeben", text: $viewModel.userInput, onCommit: {
                            if !viewModel.userInput.isEmpty {
                                viewModel.sendMessage()
                            } else {
                                viewModel.showAlert.toggle()
                            }
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
                            if !viewModel.userInput.isEmpty {
                                viewModel.sendMessage()
                            } else {
                                viewModel.showAlert.toggle()
                            }
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
}

struct ChatBubble: View {
    var content: String
    var isUser: Bool
    
    var body: some View {
        Group {
            if isUser {
                HStack {
                    Spacer()
                    Text("Du \n\(content)")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                }
            } else {
                HStack {
                    Text("Grow Bro \n\(content)")
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.leading, 10)
                    Spacer()
                }
            }
        }
        .id(UUID())
    }
}

#Preview {
    ChatView()
}
