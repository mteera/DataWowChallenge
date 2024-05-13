//
//  Router.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

enum Router {
    case pokemonList
    
    var baseURL: URL {
        switch self {
        case .pokemonList:
            return URL(string: "https://pokeapi.co/api/v2/")!
        }
    }
    
    var path: String {
        switch self {
        case .pokemonList:
            return "pokemon?limit=100000&offset=0"
        }
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}
