//
//  NetworkResponse.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation

enum NetworkResponse: Error {
    case networkError(description: String)
    case parcingError(description: String)
}
