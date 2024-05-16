//
//  PokemonListResponse.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

struct PokemonListResponse: Decodable {
    let results: [PokemonItem]
}
