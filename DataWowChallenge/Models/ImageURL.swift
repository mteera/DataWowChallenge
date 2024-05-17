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
    
    static func getDataFromImageUrl(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }.resume()
    }
}
