//
//  CustomGrid.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 13.07.2023.
//

import SwiftUI
import Kingfisher

struct CustomGrid: View {
    
    struct Column: Identifiable {
        let id = UUID()
        var items = [Photo]()
    }
    
    private let constant: CGFloat = 10
    private var items: [Photo] = []
    private var columns = [Column]()
    
    init(items: [Photo]) {
        self.items = items
        
        var columns = [Column]()
        for _ in 0 ..< 2 {
            columns.append (Column())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: 2)
        for item in items {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            
            for i in 1 ..< columnsHeight.count {
                let currentHeight = columnsHeight[i]
                if currentHeight < smallestHeight {
                    smallestHeight = currentHeight
                    smallestColumnIndex = i
                }
            }
            columns[smallestColumnIndex].items.append(item)
            columnsHeight[smallestColumnIndex] += CGFloat(item.height)
        }
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: constant) {
            ForEach(columns) { column in
                LazyVStack (spacing: constant) {
                    ForEach(column.items) { item in
                        NavigationLink(destination: ImageDetailView(urlString: item.urls.raw)) {
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
            }
        }
        .padding(.horizontal, constant )
    }
}
