//
//  NetworkService.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import Foundation
import Combine

final class NetworkService {
    
    private let session = URLSession.shared
    private var cancellable = Set<AnyCancellable>()
    
    private func createRequest(from url: URL) -> URLRequest? {
        guard let clientId = getEnvironmentVar("API_KEY") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue(clientId, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
    private func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
    
}

extension NetworkService: NetworkServiceDelegate {
    
    func getData(_ page: Int) -> AnyPublisher<[Photo], NetworkResponse> {
        
        return Deferred {
            return Future { promise in
                
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.unsplash.com"
                urlComponents.path = "/photos"
                urlComponents.queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                                            URLQueryItem(name: "per_page", value: "30"),
                                            URLQueryItem(name: "order_by", value: "popular")]
                
                guard let url = urlComponents.url,
                      let request = self.createRequest(from: url) else {
                    return promise(.failure(.networkError("Invalid URL")))
                }
                
                self.session.dataTaskPublisher(for: request)
                    .receive(on: DispatchQueue.main)
                    .tryMap{ data, resp in
                        guard let resp = resp as? HTTPURLResponse,
                              resp.statusCode >= 200 && resp.statusCode < 300 else {
                            throw NetworkResponse.networkError("Invalid response")
                        }
                        return data
                    }
                    .decode(type: [Photo].self, decoder: JSONDecoder())
                    .sink { completion in
                        
                        if case let .failure(error) = completion {
                            switch error {
                            case _ as DecodingError:
                                promise(.failure(.networkError("Failed to parse data")))
                            default:
                                promise(.failure(.networkError("Not able to get data")))
                            }
                        }
                        
                    } receiveValue: { response in
                        return promise(.success(response))
                    }
                    .store(in: &self.cancellable)
            }
        }.eraseToAnyPublisher()
        
        
    }
}
