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
    private var cancellable = Set<AnyCancellable>()
    private let networkService: NetworkServiceDelegate
    
    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
        getData()
    }
    
    private func getData() {
        networkService.getData()
            .sink { completion in
                switch completion {
                case .finished:
                    print("completion")
                case .failure(let error):
                    print("error, \(error )")
                }
            } receiveValue: { [weak self] response in
                self?.items = response
                print(self?.items)
            }
            .store(in: &cancellable)
    }
}
