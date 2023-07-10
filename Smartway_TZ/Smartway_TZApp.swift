//
//  Smartway_TZApp.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI

@main
struct Smartway_TZApp: App {
    var body: some Scene {
        WindowGroup {
            let networkService = NetworkService()
            let viewModel = ContentViewModel(networkService: networkService)
            ContentView(viewModel: viewModel)
        }
    }
}
