//
//  NetworkManager.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation
import SwiftyJSON

final class APIManager: NSObject {
    
    //Set the main URL
    private let SERVER_URL = "https://www.themealdb.com/api/json/v1/1/"
    private let IMAGES_URL = ""
    
    func makeRequest(with urlString: String, completion: @escaping(Result<Data?, NetworkingError>) -> ()) {
        
        let finalUrlString =  "\(SERVER_URL)\(urlString)"
    
        guard ReachabilityManager.isConnectedToNetwork() else {
            completion(.failure(.noInternetConnection))
            return
        }
        
        guard let url = URL(string: finalUrlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            guard let errorResult = error else {
                completion(.success(data))
                return
            }

            completion(.failure(.domainError(description: errorResult.errorMessage, errorCode: errorResult.code)))
        })
        task.resume()
    }
}
