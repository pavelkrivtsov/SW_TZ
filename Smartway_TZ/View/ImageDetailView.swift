//
//  DetailView.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 12.07.2023.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    
    private var urlString: String
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 5.0
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { state in
                adjustScale(from: state)
            }
            .onEnded { state in
                withAnimation {
                    validateScaleLimits()
                }
                lastScale = 1.0
            }
    }
    
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
            .scaleEffect(scale)
            .gesture(magnification)
    }
    
    private func adjustScale (from state: MagnificationGesture.Value) {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }
    
    private func getMinimumScaleAllowed() -> CGFloat {
        max(scale, minScale)
    }
    
    private func getMaximumScaleAllowed() -> CGFloat {
        min(scale, maxScale)
    }
    
    private func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
}

