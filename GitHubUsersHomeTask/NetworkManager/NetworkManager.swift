//
//  NetworkManager.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import Foundation

class NetworkManager {
    
    private let service: APISession
    
    init(service: APISession) {
        self.service = service
    }
    
    func fetchUserData(username: String, completion: @escaping(Result<GitUserModel, Error>) -> Void) {
        service.fetchUserData(username: username, completion: completion)
    }
}
