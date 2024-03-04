//
//  FeedViewModel.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

class FeedViewModel {
    let apiKeys: ApiKeys
    
    var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var service = ServiceAuthenticator()
    let dispatchGroup = DispatchGroup()
    
    var suggestionList: [Suggestion] = []
    var tipList: [Tips] = []
    var candidate: UserInfo?
    
    init(apiKeys: ApiKeys) {
        self.apiKeys = apiKeys
    }
    
    func numberOfRowsSuggestion() -> Int {
        return suggestionList.count
    }
    
    func suggestion(of indexPath: IndexPath) -> Suggestion {
        suggestionList[indexPath.row]
    }
    
    func numberOfRowsTips() -> Int {
        return tipList.count
    }
    
    func tips(of indexPath: IndexPath) -> Tips {
        tipList[indexPath.row]
    }
    
    func hasArrivedSuggestionAndTips() {
        if !suggestionList.isEmpty && !tipList.isEmpty {
            self.state.value = .loaded
        } else {
            self.state.value = .error
        }
    }
    
    func loadDataToken() {
        service.performAuth { userInfo in
            self.loadDataSuggestions(userInfo)
            self.candidate = userInfo
            self.loadDataTips()
            self.dispatchGroup.notify(queue: .main, execute: self.hasArrivedSuggestionAndTips)
        } onError: { error in
            self.state.value = .error
        }
    }
    
    func loadDataSuggestions(_ userInfo: UserInfo) {
        dispatchGroup.enter()
        service.getSuggestion(userInfo: userInfo, apiKey: apiKeys) { suggestions in
            self.suggestionList = suggestions
            self.dispatchGroup.leave()
        } onError: { error in
            self.dispatchGroup.leave()
        }
    }
    
    func loadDataTips() {
        dispatchGroup.enter()
        service.getTips(apiKey: self.apiKeys) { tips in
            self.tipList = tips
            self.dispatchGroup.leave()
        } onError: { error in
            self.dispatchGroup.leave()
        }
    }
}
