//
//  ContentView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ScrollView {
            listSection
        }
    }
}

extension ContentView {
    
    private var listSection: some View {
        Section {
            ForEach(viewModel.items) { item in
                let processor = DownsamplingImageProcessor(size: .init(width: item.width, height: item.height))
                
                KFImage.url(URL(string: item.urls.small))
                    .placeholder { Image("placeholderImage") }
                    .setProcessor(processor)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in  }
                    .onSuccess { result in  }
                    .onFailure { error in }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(networkService: NetworkService()))
    }
}
