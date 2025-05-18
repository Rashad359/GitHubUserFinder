//
//  GitUserModel.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

struct GitUserModel: Decodable {
    let avatarUrl: String?
    let login: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login
        case followers
        case following
        case publicRepos = "public_repos"
    }
}
