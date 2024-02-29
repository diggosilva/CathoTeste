//
//  UserSessionSingleton.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import Foundation

// MARK: UserSessionSingleton
class UserSessionSingleton {
    static let shared: UserSessionSingleton = UserSessionSingleton()
    var keys: Bindable<[ApiKeys]> = Bindable(value: [])
    private init() {}
}
