//
//  PokemonDetailsResponse.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import Foundation

struct PokemonDetailsResponse: Decodable {
    let id: Int
    let name: String
    let order: Int
    let types: [PokemonTypeEntry]
}

struct PokemonTypeEntry: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
    let url: String
}

