//
//  Models.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation

// MARK: - Photo
struct Photo: Decodable, Identifiable {
    let id: String
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case urls, id
    }
}

// MARK: - Urls
struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
