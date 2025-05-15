//
//  BaseStackView.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit

class BaseStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        alignment = .fill
        distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
