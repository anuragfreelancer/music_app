//
//  LoginViewController.swift
//  CarPlayMusicSampleApp
//
//  Created by mac on 29/08/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTxF: UITextField!
    @IBOutlet weak var passwordTxF: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        guard let email = userNameTxF.text, !email.isEmpty,
                     let password = passwordTxF.text, !password.isEmpty else {
            AlertManager.shared.showAlert(on: self, message: "Please enter both email and password.")
                   return
               }
               // Validate email format
               if !isValidEmail(email) {
                   AlertManager.shared.showAlert(on: self, message: "Please enter a valid email address.")
                   return
               }
               
               // Validate password length
               if password.count < 6 {
                   AlertManager.shared.showAlert(on: self, message: "Password must be at least 6 characters long.")
                   return
               }

               Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                   if let error = error {
                       AlertManager.shared.showAlert(on: self, message: error.localizedDescription)
                                   return
                   }

                   print("Firebase login successful")

                   if let user = Auth.auth().currentUser {
                       self.printUserInfo(user: user)
                       
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubcriptionViewController") as? SubcriptionViewController
                       self.navigationController?.pushViewController(vc!, animated: true)
                   }
               }
           }

    func isValidEmail(_ email: String) -> Bool {
          // Simple email validation
          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
          let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
          return emailPredicate.evaluate(with: email)
      }

    func printUserInfo(user: User) {
           let uid = user.uid
           let email = user.email ?? "No Email"
           let displayName = user.displayName ?? "No Display Name"

//           print("User Info:")
//           print("UID: \(uid)")
//           print("Email: \(email)")
//           print("Display Name: \(displayName)")

           user.getIDToken { token, error in
               if let error = error {
                   print("Failed to get ID Token: \(error.localizedDescription)")
                   return
               }
            //   print("ID Token: \(token ?? "No Token")")
           }

           let db = Firestore.firestore()
           let docRef = db.collection("users").document(uid)
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
                   if let data = document.data() {
                  //     print("User additional data: \(data)")
                       if let email = data["email"] as? String,
                          let password = data["password"] as? String,
                          let userDisplayName = data["username"] as? String
                       {
//                           print("email: \(email)")
//                           print("Password: \(password)")
//                           print("User Display Name: \(userDisplayName)")
                       }
                   }
               } else {
                   print("Document does not exist")
               }
           }
       }

     
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
 
/*

 
 */
