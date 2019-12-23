//
//  APIClient.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

struct APIClient: Codable {

    static func getElements(for searchQuery: String,
                           completion: @escaping (Result<[Element], AppError>) -> ()) {
     
     // using string interpolation to build endpoint url
     let elementsEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements\(searchQuery)"
         
     NetworkHelper.shared.performDataTask(with: elementsEndpointURL) { (result) in
       switch result {
       case .failure(let appError):
         completion(.failure(.networkClientError(appError)))
       case .success(let data):
         do {//any function that uses an error you must try
           let searchResults = try JSONDecoder().decode(APIClient.self, from: data)
           
           // 2. capture the array of results in the completion handler
             //completion(.success(searchResults.results))
           
         } catch {
           completion(.failure(.decodingError(error)))
         }
       }
     }
   }
   
//static func getImagesFromAPI(for imageURL: String, completion: @escaping (Result<UIImage,AppError>) ->()) {
// NetworkHelper.shared.performDataTask(with: imageURL) { (result) in
//         switch result {
//         case .failure(let appError):
//             completion(.failure(.networkClientError(appError)))
//         case .success(let data)://if you option click the data below you will get a initializer to data
//             if let myImage = UIImage(data: data) {
//                 completion(.success(myImage))
//             }
//         }
//     }
//     }
 
 static func postFavorite(postElement: Element, completion: @escaping (Result<Bool,AppError>) -> ()) {
     let postEndpointUrl = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
     guard let url = URL(string: postEndpointUrl) else {
         completion(.failure(.badURL(postEndpointUrl)))
         return
     }
     do {
         let data = try JSONEncoder().encode(postElement)
         var request = URLRequest(url: url)
                request.httpMethod = "POST"//must be capitalized or it wont work
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.httpBody = data
         NetworkHelper.shared.postDataTask(request: request) { (result) in
             switch result {
             case .failure(let appError):
                 completion(.failure(.networkClientError(appError)))
             case .success:
                 completion(.success(true))
             }
         }
     } catch {
         completion(.failure(.encodingError(error)))
     }
    
 }
 
 }
