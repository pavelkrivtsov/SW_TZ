//
//  ContentView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI
import ScrollViewLoader

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    private let constant: CGFloat = 8
    private let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            
            if viewModel.items.isEmpty {
                ProgressView()
                    .onAppear {
                        viewModel.getData()
                    }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    CustomGrid(items: viewModel.items)
                    ProgressView()
                        .scaleEffect(2)
                }
                .shouldLoadMore {
                    viewModel.getData()
                }
                .padding(constant)
                .alert(isPresented: $viewModel.hasError) {
                    Alert(title: Text(viewModel.errorMassage))
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(networkService: NetworkService()))
    }
}
