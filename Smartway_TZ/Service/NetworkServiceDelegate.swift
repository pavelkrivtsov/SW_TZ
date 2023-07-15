//
//  NetworkServiceDelegate.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation
import Combine

protocol NetworkServiceDelegate {
    func getData(_ page: Int) -> AnyPublisher<[Photo], NetworkResponse>
}
