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
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    var path: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        }
    }
    
    var query: String {
        switch self {
        case .pokemonList:
            return "limit=50&offset=0"
        }
    }
    
    var url: URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.query = query
        return components.url!
    }
}
