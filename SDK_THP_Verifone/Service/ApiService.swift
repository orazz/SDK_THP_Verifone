//
//  ApiService.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/19/20.
//

import Foundation

struct KeyWords {
    static var BASE_URL = "https://still-brook-84569.herokuapp.com/"
}

enum ApiError: Error {
    case noDataFound
    case otherError
}

final class APIService {
    
    func createRequestBin(id: String, paramters: [String: String], completion: @escaping(Result<Bool,Error>) -> Void) {
        let url = URL(string: "\(KeyWords.BASE_URL)\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error))
        }
    
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode == 200) {
                    completion(.success(true))
                } else {
                    completion(.failure(ApiError.otherError))
                }
            }
        }
        task.resume()
    }
}
