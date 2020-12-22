//
//  RecipeDetailInteractor.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit

protocol RecipeDetailInteractorLogic {
    func searchDetailsFor(searchString: String, onSuccess: @escaping([Recipe]) -> (), onError: @escaping(Error) -> ())
}

class RecipeDetailInteractor: RecipeDetailInteractorLogic {
    func searchDetailsFor(searchString: String, onSuccess: @escaping([Recipe]) -> (), onError: @escaping(Error) -> ()) {
        
    }
}
