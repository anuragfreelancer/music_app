//
//  AlertManager.swift
//  CarPlayMusicSampleApp
//
//  Created by mac on 30/08/24.
//

import Foundation
import UIKit

class AlertManager {
    
    // Singleton instance
    static let shared = AlertManager()
    
    private init() {}

    // Show alert with title and message
    func showAlert(on viewController: UIViewController, title: String = "Alert", message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
