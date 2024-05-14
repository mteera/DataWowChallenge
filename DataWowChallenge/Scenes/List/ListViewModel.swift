//
//  ListViewModel.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

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
    
    func initialLoad() {
        let list: [PokemonTableViewCellDisplayModel] = [
            PokemonTableViewCellDisplayModel(name: "bulbasaur".capitalized, imageUrl: "https://pokeapi.co/api/v2/pokemon/1/")
        ]
        
        didLoadList?(list)
    }
}
