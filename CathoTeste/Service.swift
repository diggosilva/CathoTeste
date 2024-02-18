//
//  Service.swift
//  CathoTeste
//
//  Created by Diggo Silva on 02/02/24.
//

import UIKit

struct SessionKeys: Codable {
    var response = [
        "auth": "$authkey",
        "tips": "$tipskey",
        "suggestion": "$suggestionkey",
        "survey": "$surveykey"
    ]
}

// MARK: Service
protocol ServiceAuthenticatorProtocol {
    var dataTask: URLSessionDataTask? { get set }
    func isUpdating() -> Bool
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
    
    let userId = "ee09bd39-4ca2-47ac-9c5e-9c57ba5a26dc"
    
    func getKeys(onSuccess: @escaping([SessionKeys]) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: authGET) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Status Code: \(response.statusCode)")
                }
                
                if let path = Bundle.main.path(forResource: "package-lock", ofType: "json"),
                   let data = try? Data(contentsOf: URL(filePath: path)),
                   let keys = try? JSONDecoder().decode([SessionKeys].self, from: data) {
                    onSuccess(keys)
                    print("DEBUG: Passou no OnSuccess")
                } else {
                    onError(NSError(domain: "DEBUG: Erro ao decodificar os Dados Mockados.", code: 1))
                }
            }
        })
        dataTask?.resume()
    }
}

// MARK: UserSessionSingleton
class UserSessionSingleton {
    static let shared: UserSessionSingleton = UserSessionSingleton()
    var keys: Bindable<[SessionKeys]> = Bindable(value: [])
    
    private init() {}
}
