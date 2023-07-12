//
//  ContentView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI
import ScrollViewLoader
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    private let constant: CGFloat = 8
    private let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.items, id: \.id) { item in
                        NavigationLink(destination: ImageDetailView(urlString: item.urls.regular)) {
                            KFImage.url(URL(string: item.urls.small))
                                .loadDiskFileSynchronously()
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(constant)
                        }
                    }
                }
            }.shouldLoadMore {
                viewModel.getData()
            }
            .padding(constant)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(networkService: NetworkService()))
    }
}
