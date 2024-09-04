//
//  SignUpViewController.swift
//  CarPlayMusicSampleApp
//
//  Created by mac on 29/08/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTxF: UITextField!
    @IBOutlet weak var emailTxF: UITextField!
    @IBOutlet weak var passwordTxF: UITextField!
    @IBOutlet weak var confirmPasswordTxF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        guard let username = userNameTxF.text, !username.isEmpty,
              let email = emailTxF.text, !email.isEmpty,
              let password = passwordTxF.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTxF.text, !confirmPassword.isEmpty else {
            AlertManager.shared.showAlert(on: self, message: "Please fill in all fields.")
            return
        }
        
        guard password == confirmPassword else {
       AlertManager.shared.showAlert(on: self, message: "Passwords do not match.")
            
            return
        }
        
        signUp(username: username, email: email, password: password)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func signUp(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                AlertManager.shared.showAlert(on: self, message: error.localizedDescription)

                return
            }
            
            guard let authResult = authResult else {
                AlertManager.shared.showAlert(on: self, message: "Unexpected error occurred.")
                return
            }
            
            let uid = authResult.user.uid
            print("User UID: \(uid)")
            
            self.saveUserInfoToFirestore(uid: uid, username: username, email: email, password: password)
            AlertManager.shared.showAlert(on: self, message: "User registered successfully."){
                if let subscriptionVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(subscriptionVC, animated: true)
                }
            }
        }
    }
    
    func saveUserInfoToFirestore(uid: String, username: String, email: String, password: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "username": username,
            "email": email,
            "createdAt": Timestamp(date: Date()),
            "password": password,
            "userId": uid
        ]) { error in
            if let error = error {
                print("Error saving user info to Firestore: \(error.localizedDescription)")
            } else {
                print("User info successfully saved to Firestore.")
            }
        }
    }
    
//    func subcriptionUserInfoToFirestore(uid: String, username: String, email: String, password: String) {
//        let db = Firestore.firestore()
//        db.collection("users").document(uid).setData([
//            "username": username,
//            "email": email,
//            "createdAt": Timestamp(date: Date()),
//            "password": password,
//            "userId": uid
//        ]) { error in
//            if let error = error {
//                print("Error saving user info to Firestore: \(error.localizedDescription)")
//            } else {
//                print("User info successfully saved to Firestore.")
//            }
//        }
//    }
    
}
