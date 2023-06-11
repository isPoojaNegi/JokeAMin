//
//  APIManager.swift
//  JokeAMin
//
//  Created by Pooja on 10/06/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    let apiUrl = URL(string: "https://geek-jokes.sameerkumar.website/api")
    
    func fetchJokesData(success: @escaping (JokesModel) -> Void) {
        URLSession.shared.dataTask(with: apiUrl!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching joke:", error?.localizedDescription ?? "Unknown error")
                return
            }
            let response = String(data: data, encoding: .utf8)
            let model = JokesModel(joke: response ?? "")
            success(model)
        }.resume()
    }
}

