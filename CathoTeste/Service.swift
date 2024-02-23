//
//  Service.swift
//  CathoTeste
//
//  Created by Diggo Silva on 02/02/24.
//

import UIKit

// MARK: Service
protocol ServiceAuthenticatorProtocol {
    var dataTask: URLSessionDataTask? { get set }
    func isUpdating() -> Bool
}

class ApiKeys: Decodable {
    var auth: String
    var tips: String
    var suggestions: String
    var survey: String
}

class UserInfo: Decodable {
   
}

class Suggestion: Decodable {
   
}

class Tips: Decodable {
   
}

class ServiceAuthenticator: ServiceAuthenticatorProtocol {
    var dataTask: URLSessionDataTask?
    
    func isUpdating() -> Bool {
        if let dataTask = dataTask {
            return dataTask.state == .running
        }
        return false
    }
    
    // MARK: Endpoints
    let authGET = "http://localhost:4040/auth/$userId"
    let suggestionGET = "http://localhost:4040/suggestion"
    let tipsGET = "http://localhost:4040/tips"
    let surveyPOST = "http://localhost:4040/survey/tips/$tipId/$action"
    
    func getKeys(onSuccess: @escaping(ApiKeys) -> Void, onError: @escaping(Error) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let path = Bundle.main.path(forResource: "keys", ofType: "json"),
               let data = try? Data(contentsOf: URL(filePath: path)),
               let keys = try? JSONDecoder().decode(ApiKeys.self, from: data) {
                onSuccess(keys)
                print("DEBUG: Aqui estão as Keys: \(keys)")
            } else {
                onError(NSError(domain: "DEBUG: Erro ao decodificar os Dados Mockados.", code: 1))
            }
        }
    }
    
    func performAuth(userId: String = "ee09bd39-4ca2-47ac-9c5e-9c57ba5a26dc", onSuccess: @escaping(UserInfo) -> Void, onError: @escaping(Error) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let path = Bundle.main.path(forResource: "auth", ofType: "json"),
               let data = try? Data(contentsOf: URL(filePath: path)),
               let tokens = try? JSONDecoder().decode(UserInfo.self, from: data) {
                onSuccess(tokens)
                print("DEBUG: Aqui estão os Tokens: \(tokens)")
            } else {
                onError(NSError(domain: "DEBUG: Erro ao decodificar os Dados Mockados.", code: 1))
            }
        }
    }
    
    func getSuggestion(userInfo: UserInfo, apiKey: ApiKeys, onSuccess: @escaping([Suggestion]) -> Void, onError: @escaping(Error) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let path = Bundle.main.path(forResource: "suggestions", ofType: "json"),
               let data = try? Data(contentsOf: URL(filePath: path)),
               let suggestions = try? JSONDecoder().decode([Suggestion].self, from: data) {
                onSuccess(suggestions)
                print("DEBUG: Aqui estão as Suggestions: \(suggestions)")
            } else {
                onError(NSError(domain: "DEBUG: Erro ao decodificar os Dados Mockados.", code: 1))
            }
        }
    }
    
    func getTips(apiKey: ApiKeys, onSuccess: @escaping([Tips]) -> Void, onError: @escaping(Error) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let path = Bundle.main.path(forResource: "tips", ofType: "json"),
               let data = try? Data(contentsOf: URL(filePath: path)),
               let tips = try? JSONDecoder().decode([Tips].self, from: data) {
                onSuccess(tips)
                print("DEBUG: Aqui estão as Tips: \(tips)")
            } else {
                onError(NSError(domain: "DEBUG: Erro ao decodificar os Dados Mockados.", code: 1))
            }
        }
    }
}

// MARK: UserSessionSingleton
class UserSessionSingleton {
    static let shared: UserSessionSingleton = UserSessionSingleton()
    var keys: Bindable<[ApiKeys]> = Bindable(value: [])
    
    private init() {}
}
