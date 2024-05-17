//
//  ListViewModel.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

protocol ListViewModelInput {
    func initialLoad()
    func reloadData()
    func search(with query: String)
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
    
    private var pokemonListResponse: PokemonListResponse?
    
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
    
    func search(with query: String) {
        if query.isEmpty {
            let list: [PokemonTableViewCellDisplayModel] = makePokemonTableViewCellDisplayModels(from: pokemonListResponse?.results ?? [])
            return
        }
        
        let filteredList = pokemonListResponse?.results.filter { $0.name.localizedCaseInsensitiveContains(query) } ?? []
        let list: [PokemonTableViewCellDisplayModel] = makePokemonTableViewCellDisplayModels(from: filteredList)

        didLoadList?(list)
    }

    
    private func fetchData() {
        pokemonUseCase.fetchPokemonList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                pokemonListResponse = response
                let list: [PokemonTableViewCellDisplayModel] = makePokemonTableViewCellDisplayModels(from: response.results)
                
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
    
    private func makePokemonTableViewCellDisplayModels(from items: [PokemonItem]) -> [PokemonTableViewCellDisplayModel] {
        items.map { item -> PokemonTableViewCellDisplayModel in
            return PokemonTableViewCellDisplayModel(name: item.name.capitalized)
        }
    }
}
