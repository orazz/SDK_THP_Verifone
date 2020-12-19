//
//  ViewModel.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/19/20.
//

import Foundation

final class ViewModel {
    private var apiService: APIService
    var didStartLoading: () -> Void = { }
    var didFinishLoading: () -> Void = { }
    var didFinishWithError: (Error) -> Void = { _ in }
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func createRequestBin(id: String, paramters: [String: String]) {
        self.didStartLoading()
        
        apiService.createRequestBin(id: id, paramters: paramters, completion: { [weak self] res in
            switch res {
            case .failure(let error):
                print(error)
                self?.didFinishWithError(error)
            case .success( _):
                self?.didFinishLoading()
            }
        })
    }
    
}
