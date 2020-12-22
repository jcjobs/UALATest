//
//  Error+Extensions.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
    var errorMessage: String { return (self as NSError).localizedDescription }
}
