//
//  GitUserModel.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

struct GitUserModel: Decodable {
    let avatar_url: String?
    let login: String?
    let followers: Int?
    let following: Int?
    let public_repos: Int?
}
