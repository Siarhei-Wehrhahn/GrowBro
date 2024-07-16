//
//  SplashView.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            
            Text("Grow Bro")
                .foregroundStyle(.yellow)
                .bold()
                .font(Font.system(size: 60))
        }
    }
}

#Preview {
    SplashView()
}
