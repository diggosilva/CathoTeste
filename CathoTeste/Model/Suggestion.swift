//
//  Suggestion.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import Foundation

class Suggestion: Decodable {
    let jobAdTile: String
    let company: String
    let date: String
    let totalPositions: Int
    let locations: [String]
    let salary: Salary
}

class Salary: Decodable {
    let real: String
    let range: String
}
