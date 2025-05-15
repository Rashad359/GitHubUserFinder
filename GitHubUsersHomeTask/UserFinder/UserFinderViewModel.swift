//
//  UserFinderViewModel.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit

enum State {
    case loaded(GitUserModel)
    case error(Error)
}

protocol UserFinderDelegate {
    func render(_ state: State)
}

class UserFinderViewModel {
    
    let networkManager: NetworkManager = DependencyContainer.shared.networkManager
    
    private var delegate: UserFinderDelegate? = nil
    
    func subscribe(_ delegate: UserFinderDelegate) {
        self.delegate = delegate
    }
    
    func fetchUserData(username: String) {
        networkManager.fetchUserData(username: username) { result in
            switch result {
            case .success(let data):
                self.delegate?.render(.loaded(data))
            case .failure(let error):
                self.delegate?.render(.error(error))
            }
        }
    }
}
