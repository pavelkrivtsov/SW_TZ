//
//  ContentViewModel.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var items: [Photo] = []
    private var page: Int = 0
    private var cancellable = Set<AnyCancellable>()
    private let networkService: NetworkServiceDelegate
    
    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
        getData()
    }
    
    func getData() {
        networkService.getData(page)
            .sink { completion in
                switch completion {
                case .finished:
                    print("completion")
                case .failure(let error):
                    print("error, \(error )")
                }
            } receiveValue: { [weak self] response in
                self?.items.append(contentsOf: response)
                self?.page += 1
            }
            .store(in: &cancellable)
    }
}
