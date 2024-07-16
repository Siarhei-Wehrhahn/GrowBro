//
//  LoadingDotsView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

import SwiftUI

struct LoadingDotsView: View {
    @State private var scale: CGFloat = 0.5
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: scale
                    )
            }
        }
        .onAppear {
            scale = 1.0
        }
    }
}

#Preview {
    LoadingDotsView()
}
