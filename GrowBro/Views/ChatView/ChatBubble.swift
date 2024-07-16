//
//  ChatBubble.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct ChatBubble: View {
    var content: String?
    var isUser: Bool
    var isLoading: Bool = false
    
    var body: some View {
        Group {
            if isUser {
                HStack {
                    Spacer()
                    if let content = content {
                        Text("Du \n\(content)")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 10)
                    }
                }
            } else {
                HStack {
                    if isLoading {
                        LoadingDotsView()
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                    } else if let content = content {
                        Text("Grow Bro \n\(content)")
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
            }
        }
        .id(UUID())
    }
}


#Preview {
    ChatBubble(content: "Hallo", isUser: true)
}
