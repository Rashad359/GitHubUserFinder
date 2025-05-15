//
//  DependencyContainer.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var networkManager: NetworkManager = {
        return NetworkManager(service: URLSessionAdapter())
    }()
}
