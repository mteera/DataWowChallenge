//
//  CoinsUseCase.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

protocol PokemonUseCaseProtocol {
    func fetchPokemonList(completion: @escaping (Result<PokemonListResponse, NetworkError>) -> Void)
    func fetchPokemonDetails(name: String, completion: @escaping (Result<PokemonDetailsResponse, NetworkError>) -> Void)
}

class PokemonUseCase: PokemonUseCaseProtocol {
    
    private let serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider = ServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchPokemonList(completion: @escaping (Result<PokemonListResponse, NetworkError>) -> Void) {
        serviceProvider.request(router: Router.pokemonList, responseType: PokemonListResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemonDetails(name: String, completion: @escaping (Result<PokemonDetailsResponse, NetworkError>) -> Void) {
        serviceProvider.request(
            router: Router.pokemonDetails(name: name),
            responseType: PokemonDetailsResponse.self
        ) { result in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
