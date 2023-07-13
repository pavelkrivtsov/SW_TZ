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
    @Published var hasError: Bool = false
    var errorMassage = String()
    private var currentPage: Int = 1
    private var cancellable = Set<AnyCancellable>()
    private let networkService: NetworkServiceDelegate
    
    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
    }
    
    func getData() {
        networkService.getData(currentPage)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("completion")
                case .failure(let error):
                    self?.hasError = true
                    self?.errorMassage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.items.append(contentsOf: response)
                self?.currentPage += 1
            }
            .store(in: &cancellable)
    }
}
