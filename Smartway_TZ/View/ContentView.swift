//
//  ContentView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            List {
                listSection
            }.navigationTitle("Unsplash API")
        }
    }
}

extension ContentView {
    
    private var listSection: some View {
        Section {
            ForEach(viewModel.items) { item in
                ListRow(item: item)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(networkService: NetworkService() ))
    }
}
