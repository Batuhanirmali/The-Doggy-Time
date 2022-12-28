//
//  NetworkService.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchAllCategories(completion: @escaping(Result<AllBreed, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    } //3. oluşturma
    
    func favoriteDogs(dogId: String, name:String, completion: @escaping(Result<Favorite, Error>) -> Void) {
        let params = ["name": name]
        
        request(route: .favoriteDogs(dogId), method: .post, parameters: params ,completion: completion )
    }
    
    func fetchCategoryDogs(categoryId: String, completion: @escaping(Result<[Breed], Error>) -> Void) {
        request(route: .fetchCategoryDogs(categoryId), method: .get, completion: completion)
    }
    
    func fetchFavoriteDogs(completion: @escaping(Result<[Favorite], Error>) -> Void) {
        request(route: .fetchFavoriteDogs, method: .get, completion: completion)
    }
    
    
    
    private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = crateRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
           
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response,
            error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            }else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: The path the resource in the backend
    ///   - method: Type of request to be made
    ///   - parameters: Extra information you need to pass to he backend
    /// - Returns: URLRequest
      func crateRequest(route: Route,
                              method: Method,
                              parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlCompenent = URLComponents(string: urlString)
                urlCompenent?.queryItems = params.map {URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlCompenent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
