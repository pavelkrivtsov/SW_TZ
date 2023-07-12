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
    private var spacing: CGFloat = 8
    private var horizontalPadding: CGFloat = 8
    
    init(items: [Photo]) {
        self.items = items
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            VStack {
                ForEach(self.items.prefix(self.items.count / 2), id: \.id) { item in
                    NavigationLink(destination: ImageDetailView(urlString: item.urls.regular)) {
                        getItemView(item: item)
                    }
                }
            }
            VStack {
                ForEach(self.items.suffix(self.items.count / 2), id: \.id) { item in
                    NavigationLink(destination: ImageDetailView(urlString: item.urls.regular)) {
                        getItemView(item: item)
                    }
                }
            }
        }
        .padding(horizontalPadding)
    }
    
    private func getItemView(item: Photo) -> some View {
        KFImage.url(URL(string: item.urls.small))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .resizable()
            .scaledToFit()
            .cornerRadius(spacing)
    }
}

