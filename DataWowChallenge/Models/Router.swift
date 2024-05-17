//
//  Router.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

enum Router {
    case pokemonList
    case pokemonDetails(name: String)
    
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    var path: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        case .pokemonDetails(let name):
            return "pokemon/\(name)"
        }
    }
    
    var query: String {
        switch self {
        case .pokemonList:
            return "limit=100000&offset=0"
        case .pokemonDetails:
            return "" // No query for pokemonDetails
        }
    }
    
    var url: URL {
        // No need to clean path and query separately as they are constructed correctly now
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.query = query.isEmpty ? nil : query // Set query only if it's not empty
        return components.url!
    }
}
