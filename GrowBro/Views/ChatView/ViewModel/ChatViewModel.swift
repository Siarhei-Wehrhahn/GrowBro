//
//  ChatViewModel.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []
    @Published var userMessages: [String] = []
    @Published var userInput = ""
    @Published var showAlert = false
    let repo = ChatRepository()
    
    @MainActor
    func sendMessage() {
        Task {
            do {
                let result = try await repo.sendRequest(prompt: userInput)
                messages.append(result)
                userMessages.append(userInput)
                userInput = ""
            } catch let error as ChatRepository.RequestError {
                handleRequestError(error)
            } catch {
                print("ChatViewModel: Unbekannter Fehler: \(error)")
            }
        }
    }
    
    private func handleRequestError(_ error: ChatRepository.RequestError) {
        switch error {
        case .encodingError:
            print("Fehler beim Kodieren der Anfrage.")
        case .decodingError:
            print("Fehler beim Dekodieren der Antwort.")
        case .networkError(let netError):
            print("Netzwerkfehler: \(netError)")
        case .invalidResponse:
            print("Ungültige Antwort vom Server.")
        default:
            print("Unbekannter Fehler: \(error)")
        }
        showAlert = true
    }
}
