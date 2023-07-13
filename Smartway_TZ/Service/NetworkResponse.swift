//
//  NetworkResponse.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation

enum NetworkResponse: LocalizedError {
    
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .networkError(let massage):
            return NSLocalizedString(massage, comment: "")
        }
    }
}
