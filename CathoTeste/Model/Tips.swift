//
//  Tips.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import Foundation

class Tips: Decodable {
    let id: String
    let description: String
    let button: Button
}

class Button: Decodable {
    let show: Bool
    let label: String
    let url: String
}
