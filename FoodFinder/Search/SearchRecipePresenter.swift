//
//  SearchRecipePresenter.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation

protocol SearchRecipePresenterLogic {
    func searchResultsFor(searchString: String)
}

class SearchRecipePresenter: SearchRecipePresenterLogic {
    
    private var viewModel: SearchFoodDisplayLogic
    private var interactor: SearchRecipeInteractorLogic
    
    init(with viewModel: SearchFoodDisplayLogic) {
        self.viewModel = viewModel
        interactor = SearchRecipeInteractor()
    }
    
    func searchResultsFor(searchString: String) {
        viewModel.showLoader()
        interactor.searchResultsFor(searchString: searchString) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewModel.showRecipeResult(with: result)
                self.viewModel.hideLoader()
            }
        } onError: { [weak self] error in
            DispatchQueue.main.async {
                self?.viewModel.showErrorMessage(with: error.localizedDescription)
                self?.viewModel.hideLoader()
            }
        }
    }
    
}
