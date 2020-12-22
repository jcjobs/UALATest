//
//  SearchRecipePresenter.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation
import UIKit

protocol SearchRecipePresenterLogic {
    func searchResultsFor(searchString: String)
    func showRecipeDetail(with recipeId: Int)
}

class SearchRecipePresenter: SearchRecipePresenterLogic {
    
    private var viewModel: SearchFoodDisplayLogic
    private var interactor: SearchRecipeInteractorLogic
    private var wireframe: SearchRecipeWireframe
    
    init(with viewModel: SearchFoodDisplayLogic) {
        self.viewModel = viewModel
        interactor = SearchRecipeInteractor()
        let navigation = (self.viewModel as? UIViewController)?.navigationController
        wireframe = SearchRecipeWireframe(with: navigation)
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
    
    func showRecipeDetail(with recipeId: Int) {
        wireframe.showRecipeDetail(recipeId: recipeId)
    }
    
}
