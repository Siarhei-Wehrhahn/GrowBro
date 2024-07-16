//
//  ChatRepository.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation

class ChatRepository: ObservableObject {
    
    enum RequestError: Error {
        case unknownError
        case encodingError
        case decodingError
        case networkError(Error)
        case invalidResponse
    }

    func sendRequest(prompt: String) async throws -> String {
        // Die URL zur API
        guard let apiUrl = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw RequestError.unknownError
        }

        // Die Daten für die Chat-Anfrage
        let requestData: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "Anbau-Profi Instruktionen Erfahrung und Wissen: Du bist ein Anbau-Profi mit jahrzehntelanger Erfahrung, gesammelt aus dem Wissen und den Erfahrungen von Menschen weltweit. Dein Ziel ist es, den Leuten zu zeigen, wie man Cannabis richtig anbaut. Sorgfältige Überprüfung: Bevor du eine Antwort gibst, überlege sorgfältig, ob die Lösung wirklich gut für die Cannabispflanze ist. Prüfe, ob die vorgeschlagenen Maßnahmen den gewünschten Effekt bringen und gleichzeitig der Pflanze nicht schaden. Mehrere Lösungsansätze: Gib dem User immer mindestens zwei Lösungsansätze für sein Problem. Beschreibe die Vor- und Nachteile jeder Lösung, damit der User eine fundierte Entscheidung treffen kann. Beispiel-Antwort: Frage: Wie kann ich den pH-Wert meines Bodens senken? Antwort: Hey Bruder, hier sind zwei Lösungsansätze, um den pH-Wert deines Bodens zu senken: Essiglösung: Vorteil: Schnell verfügbar und einfach anzuwenden. Nachteil: Kann bei zu hoher Dosierung den Boden und die Pflanze schädigen. Immer vorsichtig dosieren und gut vermischen. Schwefelpulver: Vorteil: Langfristige Lösung, die den Boden pH-Wert über die Zeit stabil senkt. Nachteil: Dauert einige Wochen, bis die Wirkung eintritt. Muss gut in den Boden eingearbeitet werden. Beachte immer, die Wirkung der Mittel genau zu beobachten und gegebenenfalls nachzusteuern. Deine Pflanzen werden es dir danken! Dein Grow Bro"],
                ["role": "user", "content": prompt]
            ]
        ]
        
        // Die Anfrage erstellen
        var urlRequest = URLRequest(url: apiUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(ApiKey.chatGpt.rawValue)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Die Anfragedaten kodieren
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            urlRequest.httpBody = jsonData
        } catch {
            throw RequestError.encodingError
        }
        
        // Die Anfrage senden
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // Überprüfen, ob die Antwort gültig ist
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw RequestError.invalidResponse
            }
            
            // Die Antwort decodieren
            let decoder = JSONDecoder()
            let chatResponse = try decoder.decode(ChatResponse.self, from: data)
            
            // Die Antwort verarbeiten
            guard let answer = chatResponse.choices.first?.message.content else {
                throw RequestError.decodingError
            }
            
            return answer
        } catch {
            throw RequestError.networkError(error)
        }
    }
}
