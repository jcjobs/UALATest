//
//  SearchRecipeInteractor.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation
import SwiftyJSON

protocol SearchRecipeInteractorLogic {
    func searchResultsFor(searchString: String, onSuccess: @escaping([Recipe]) -> (), onError: @escaping(Error) -> ())
}

class SearchRecipeInteractor: SearchRecipeInteractorLogic {

    func searchResultsFor(searchString: String, onSuccess: @escaping([Recipe]) -> (), onError: @escaping(Error) -> ()) {
        var searchResults: [Recipe] = [Recipe]()
        APIManager().makeRequest(with: "search.php?s=\(searchString)") { result in
            switch result {
            case .success(let data):
                if let dataFromNetworking = data {
                    if let json = try? JSON(data: dataFromNetworking){
                        for item in json["meals"].arrayValue {
                            let newRecipe = Recipe(id: item["idMeal"].intValue, title: item["strMeal"].stringValue, detail: item["strCategory"].stringValue, urlImage: item["strMealThumb"].stringValue)
                            searchResults.append(newRecipe)
                        }
                    }
                }
                onSuccess(searchResults)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
