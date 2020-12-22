//
//  Recipe.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation

struct Recipe {
    let id: Int
    let title: String
    let detail: String
    let urlImage: String
    
    var ingredients:[String] = [String]()
    
    init(id:Int, title: String, detail: String, urlImage: String) {
        self.id = id
        self.title = title
        self.detail = detail
        self.urlImage = urlImage
    }
}
