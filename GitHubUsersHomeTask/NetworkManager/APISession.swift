//
//  URLSession.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit

protocol APISession {
    func fetchUserData(username: String, completion: @escaping(Result<GitUserModel, Error>) -> Void)
}
