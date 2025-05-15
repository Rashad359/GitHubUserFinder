//
//  URLSessionAdapter.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import Foundation

class URLSessionAdapter: APISession {
    func fetchUserData(username: String, completion: @escaping(Result<GitUserModel, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Something went wrong in decoding... \(error)")
                completion(.failure(error))
            }
            
            if let data {
                do {
                    let responseData = try JSONDecoder().decode(GitUserModel.self, from: data)
                    completion(.success(responseData))
                } catch {
                    print("Something went wrong in data... \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
