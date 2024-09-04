//
//  Messages.swift
//  LUDIAN
//
//  Created by mac on 28/05/24.
//

import Foundation
import UIKit


struct MessageStruct {
    
    static let Failed_Password = "Failed to reset password. Please try again."
    
    static let Select_Email_Phone = "Please select Email or SMS to reset your password"
    
    static let select_vehicle_type = "Please select vehicle type"
    
    static let first_name = "Please enter first name"
    
    static let last_name = "Please enter last name"
    
    static let email = "Please enter email address"
    
    static let invalid_email = "Invalid email address"
    
    static let password = "Please enter password"
    
    static let confirm_password = "Please enter confirm password"
    
    static let password_not_matched = "Password not matched"
    
    static let mobile = "Please enter mobile number"
   
    static let email_Password = "Please enter both email and password."
}



class ValidationHelper {

    static let shared = ValidationHelper()

    private init() {}

    func isValidEmail(_ email: String) -> Bool {
        // Regular expression to validate email format
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        // Example password validation: minimum 8 characters, at least one letter and one number
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}

class AlertHelper {

    static let shared = AlertHelper()

    private init() {}

    func showAlert(message: String, in viewController: UIViewController, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
