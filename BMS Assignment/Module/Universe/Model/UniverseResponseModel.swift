//
//  UniverseResponse.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 08/01/23.
//

import Foundation
//MARK: Base model
struct UniverseBase: Codable {
    let lineup: [String: String]
    let universe: [String: Universe]
}

//MARK: Universes model
struct Universe: Codable {
    let name: String
    let superheroes: [String: Superhero]
}

//MARK: Superhero model
struct Superhero: Codable {
    let name: String
    let imageURL: String
    let isLeader: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case isLeader = "is_leader"
    }
}
