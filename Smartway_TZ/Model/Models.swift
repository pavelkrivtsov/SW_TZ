//
//  Models.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation

// MARK: - Photo
struct Photo: Decodable, Hashable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let photoDescription: String?
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id, urls, width, height
        case createdAt = "created_at"
        case photoDescription = "description"
    }
}

// MARK: - Urls
struct Urls: Decodable, Hashable {
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
