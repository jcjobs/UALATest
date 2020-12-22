//
//  RecipeDetailPresenter.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

protocol RecipeDetailPresenterLogic {
    func getRecipeDetailWith(recipeId: Int)
}

class RecipeDetailPresenter: RecipeDetailPresenterLogic {
    
    private var interactor: RecipeDetailInteractorLogic
    private var viewModel: RecipeDetailDysplayLogic
    
    init(with viewModel: RecipeDetailDysplayLogic) {
        self.viewModel = viewModel
        interactor = RecipeDetailInteractor()
    }
    
    func getRecipeDetailWith(recipeId: Int) {
        viewModel.showLoader()
        interactor.searchDetailsFor(recipeId: recipeId) { [weak self] recipeResult in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewModel.showDetailFor(recipe: recipeResult)
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
