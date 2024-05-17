//
//  DetailsViewModel.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import Foundation

struct DetailsViewContext {
    let name: String
}

protocol DetailsViewModelInput {
    func initialLoad()
}

protocol DetailsViewModelOutput: AnyObject {
    var didLoadSections: (([DetailsViewSection]) -> Void)? { get set }
    var didReceiveError: ((String) -> Void)? { get set }
}

protocol DetailsViewModelProtocol: DetailsViewModelInput, DetailsViewModelOutput {
    var input: DetailsViewModelInput { get }
    var output: DetailsViewModelOutput { get }
}

class DetailsViewModel: DetailsViewModelProtocol {
    var input: DetailsViewModelInput { self }
    var output: DetailsViewModelOutput { self }
    
    let context: DetailsViewContext
    let pokemonUseCase: PokemonUseCaseProtocol
    
    var didLoadSections: (([DetailsViewSection]) -> Void)?
    var didReceiveError: ((String) -> Void)?
    
    init(
        context: DetailsViewContext,
        pokemonUseCase: PokemonUseCaseProtocol = PokemonUseCase()
    ) {
        self.context = context
        self.pokemonUseCase = pokemonUseCase
    }
    
    func initialLoad() {
        pokemonUseCase.fetchPokemonDetails(name: context.name.lowercased()) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let imageUrlString: String = getImageUrlString(from: response.id)
                
                let sections: [DetailsViewSection] = [
                    .hero(makeDetailsHeroTableViewCellDisplayModel(imageUrlString: imageUrlString)),
                    .information(makeDetailsInformationTableViewCellDisplayModel(from: response))
                ]
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.didLoadSections?(sections)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.didReceiveError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func makeDetailsHeroTableViewCellDisplayModel(imageUrlString: String) -> DetailsHeroTableViewCellDisplayModel {
        let imageUrl: URL? = URL(string: imageUrlString)
        return DetailsHeroTableViewCellDisplayModel(imageUrl: imageUrl)
    }
    
    private func getImageUrlString(from order: Int) -> String {
        let imageBaseUrl: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/\(order).svg"
        return imageBaseUrl
    }
    
    private func makeDetailsInformationTableViewCellDisplayModel(from response: PokemonDetailsResponse) -> DetailsInformationTableViewCellDisplayModel {
        return DetailsInformationTableViewCellDisplayModel(
            name: response.name.capitalized,
            number: String(response.id),
            types: response.types.map(\.type.name)
        )
    }
}
