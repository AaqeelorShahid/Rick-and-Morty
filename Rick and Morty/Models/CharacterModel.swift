//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Shahid Aaqeel on 2/8/22.
//

import Foundation

struct Response: Decodable {
    let info: Info
    let results: [Character]
}

struct Character: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var image: String
}

struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
