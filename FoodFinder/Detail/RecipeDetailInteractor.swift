//
//  RecipeDetailInteractor.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import UIKit
import SwiftyJSON

protocol RecipeDetailInteractorLogic {
    func searchDetailsFor(recipeId: Int, onSuccess: @escaping(Recipe) -> (), onError: @escaping(Error) -> ())
}

class RecipeDetailInteractor: RecipeDetailInteractorLogic {
    func searchDetailsFor(recipeId: Int, onSuccess: @escaping(Recipe) -> (), onError: @escaping(Error) -> ()) {
        APIManager().makeRequest(with: "lookup.php?i=\(recipeId)") { result in
            switch result {
            case .success(let data):
                
                if let dataFromNetworking = data {
                    if let json = try? JSON(data: dataFromNetworking){
                        for item in json["meals"].arrayValue {
                            var newRecipe = Recipe(id: item["idMeal"].intValue, title: item["strMeal"].stringValue, detail: item["strCategory"].stringValue, urlImage: item["strMealThumb"].stringValue)
                            
                            for index in 1...20 {
                                let newIngredient = item["strIngredient\(index)"].stringValue
                                if !newIngredient.isEmpty {
                                    newRecipe.ingredients.append(newIngredient)
                                }
                            }
                            onSuccess(newRecipe)
                            return
                        }
                    }
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
}
