//
//  Model.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation

struct ChatResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let role: String
    let content: String
}
