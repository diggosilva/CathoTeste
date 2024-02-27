//
//  LoadingViewModel.swift
//  CathoTeste
//
//  Created by Diggo Silva on 21/02/24.
//

import Foundation

enum LoadingViewControllerStates {
    case loading
    case loaded(ApiKeys)
    case error
}

protocol LoadingViewModelProtocol {
    var state: Bindable<LoadingViewControllerStates> { get set }
    
    // Request
    func loadData()
}

class LoadingViewModel: LoadingViewModelProtocol {
    var state: Bindable<LoadingViewControllerStates> = Bindable(value: .loading)
    
    private var service = ServiceAuthenticator()
    
    func loadData() {
        self.service.getKeys { apiKeys in
            self.state.value = .loaded(apiKeys)
            print(apiKeys)
        } onError: { error in
            self.state.value = .error
        }
    }
}
