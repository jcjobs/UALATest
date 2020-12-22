//
//  Recipe.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation

struct Recipe {
    let title: String
    let detail: String
    let urlImage: String
    
    init(title: String, detail: String, urlImage: String) {
        self.title = title
        self.detail = detail
        self.urlImage = urlImage
    }
}
