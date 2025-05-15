//
//  UIViewController+Ext.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
