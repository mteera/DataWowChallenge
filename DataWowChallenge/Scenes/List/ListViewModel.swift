//
//  ListViewModel.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation
import SVGKit

protocol ListViewModelInput {
    func initialLoad()
}

protocol ListViewModelOutput: AnyObject {
    var didLoadList: (([PokemonTableViewCellDisplayModel]) -> Void)? { get set }
}

protocol ListViewModelProtocol: ListViewModelInput, ListViewModelOutput {
    var input: ListViewModelInput { get }
    var output: ListViewModelOutput { get }
}

class ListViewModel: ListViewModelProtocol {
    var input: ListViewModelInput { self }
    var output: ListViewModelOutput { self }
    
    var didLoadList: (([PokemonTableViewCellDisplayModel]) -> Void)?
    
    let pokemonUseCase: PokemonUseCaseProtocol
    
    init(pokemonUseCase: PokemonUseCaseProtocol = PokemonUseCase()) {
        self.pokemonUseCase = pokemonUseCase
    }
    
    func initialLoad() {
        pokemonUseCase.fetchPokemonList { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let list: [PokemonTableViewCellDisplayModel] = response.results.map { item -> PokemonTableViewCellDisplayModel in
                    return PokemonTableViewCellDisplayModel(name: item.name)
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    didLoadList?(list)
                }
            case .failure(let failure):
                break
            }
        }
    }
}
