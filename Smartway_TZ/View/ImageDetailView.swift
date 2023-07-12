//
//  DetailView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 12.07.2023.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var body: some View {
        
        KFImage.url(URL(string: urlString))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .resizable()
            .scaledToFit()
    }
}
