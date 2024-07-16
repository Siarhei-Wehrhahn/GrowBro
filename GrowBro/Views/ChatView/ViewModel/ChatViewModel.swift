//
//  ChatViewModel.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var chatMessages: [ChatMessage] = []
    @Published var userInput = ""
    @Published var showAlert = false
    @Published var isLoading = false
    let repo = ChatRepository()
    
    @MainActor
    func sendMessage() {
        let userMessage = ChatMessage(content: userInput, isUser: true)
        chatMessages.append(userMessage)
        userInput = ""
        isLoading = true
        
        Task {
            do {
                let result = try await repo.sendRequest(prompt: userMessage.content)
                let growBroMessage = ChatMessage(content: result, isUser: false)
                chatMessages.append(growBroMessage)
            } catch {
                print("ChatViewModel: \(error)")
            }
            isLoading = false
        }
    }
}

