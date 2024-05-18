//
//  ImageUrl.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 16/5/2567 BE.
//

import Foundation

struct ImageURL {
    static let baseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/"

    static func url(for id: String) -> URL? {
        let urlString = baseURL + id + ".svg"
        return URL(string: urlString)
    }
}
