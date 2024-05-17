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
    func reloadData()
}

protocol ListViewModelOutput: AnyObject {
    var didLoadList: (([PokemonTableViewCellDisplayModel]) -> Void)? { get set }
    var didReceiveError: ((String) -> Void)? { get set }
}

protocol ListViewModelProtocol: ListViewModelInput, ListViewModelOutput {
    var input: ListViewModelInput { get }
    var output: ListViewModelOutput { get }
}

class ListViewModel: ListViewModelProtocol {
    var input: ListViewModelInput { self }
    var output: ListViewModelOutput { self }
    
    var didLoadList: (([PokemonTableViewCellDisplayModel]) -> Void)?
    var didReceiveError: ((String) -> Void)?
    
    let pokemonUseCase: PokemonUseCaseProtocol
    
    init(pokemonUseCase: PokemonUseCaseProtocol = PokemonUseCase()) {
        self.pokemonUseCase = pokemonUseCase
    }
    
    func initialLoad() {
        fetchData()
    }
    
    func reloadData() {
        fetchData()
    }
    
    private func fetchData() {
        pokemonUseCase.fetchPokemonList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let list: [PokemonTableViewCellDisplayModel] = response.results.map { item -> PokemonTableViewCellDisplayModel in
                    return PokemonTableViewCellDisplayModel(name: item.name.capitalized)
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.didLoadList?(list)
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.didReceiveError?(failure.localizedDescription)
                }
            }
        }
    }
}
