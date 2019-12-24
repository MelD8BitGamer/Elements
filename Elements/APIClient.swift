//
//  APIClient.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

struct APIClient: Codable {
//this method takes data from the API and decodes it into a format that swift can understand, which is our model(in this case Element)
    static func getElements(for urlString: String,
                           completion: @escaping (Result<[Element], AppError>) -> ()) { //it takes in a valid url and a completion handler
// the completion handler captures the value of the decoded data from API(like the phone call)
         
        guard let url = URL(string: urlString) else { completion(.failure(.badURL(urlString)))
            return
           
            }
        let urlRequest = URLRequest(url: url)
        
        
        NetworkHelper.shared.postDataTask(request: urlRequest) { (result) in
       switch result {
       case .failure(let appError):
         completion(.failure(.networkClientError(appError)))
       case .success(let data):
         do {//any function that uses an error you must try//anytime you decode data from JSON you need to include .self
           let searchResults = try JSONDecoder().decode([Element].self, from: data)
            completion(.success(searchResults))
           // 2. capture the array of results in the completion handler
             //completion(.success(searchResults.results))
           
         } catch {
           completion(.failure(.decodingError(error)))
         }
       }
     }
   }
 
 static func postFavorite(postElement: Element, completion: @escaping (Result<Bool,AppError>) -> ()) {
     let postEndpointUrl = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"

    guard let urlString = URL(string: postEndpointUrl) else {
        completion(.failure(.badURL(postEndpointUrl)))
        return
    }
    do {
    var urlRequest = URLRequest(url: urlString)
        //anytime a function throws an error you need to use TRY, it tries to handle the error being thrown. There are 4 ways to handle an error, 1. rethrow it, 2.do catch block(the only way to see what the error is, 3. try? if the function does throw an error you wont see it AND your app wont crash, 4. bang out the try(only if you are certain there is no error if there is an error your app will crash. there are 3 properties of request that  need to be filled out before we call our method 1.httpMethod, 2. addValue(will add a new entry to the API) but setValue changes the data, 3. httpBody,
        
        let encodedData = try JSONEncoder().encode(postElement)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = encodedData
        NetworkHelper.shared.postDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success:
                completion(.success(true))
            }
        }
    } catch {
        completion(.failure(.encodingError(error)))//if the JSONEncoder throws an error the catch block catches (if you have multiple errors you can put it in the same do catch)
    }
    
  }
}

