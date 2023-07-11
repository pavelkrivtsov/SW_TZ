//
//  CustomGrid.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 11.07.2023.
//

import SwiftUI
import Kingfisher

struct CustomGrid: View {
    
    private var items: [Photo]
    private var spacing: CGFloat
    private var horizontalPadding: CGFloat
    
    init(items: [Photo],
         spacing: CGFloat = 8,
         horizontalPadding: CGFloat = 8) {
        self.items = items
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            VStack {
                ForEach(self.items.prefix(self.items.count / 2), id: \.id) { item in
                    getItemView(item: item)
                }
            }
            VStack {
                ForEach(self.items.suffix(self.items.count / 2), id: \.id) { item in
                    getItemView(item: item)
                }
            }
        }
        .padding(horizontalPadding)
    }
    
    private func getItemView(item: Photo) -> some View {
        KFImage.url(URL(string: item.urls.regular))
            .placeholder { Image("placeholderImage") }
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in }
            .onFailure { error in }
            .resizable()
            .scaledToFit()
    }
}

