//
//  ViewRouter.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation

enum Page {
    case splash
    case home
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .splash
}
