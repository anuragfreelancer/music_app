//
//  SubcriptionViewController.swift
//  CarPlayMusicSampleApp
//
//  Created by mac on 29/08/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreInternal
import FirebaseCore


class SubcriptionViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueBtn: UIButton!
    
    //    var monthAndWeek = [ "₹0/Month" , "₹300/Month" ]
    //    var forDay = ["For 30 days" , "Unmited Access"]//
    //    var condition = ["terms & condition apply" , "terms & condition apply"]
    //    var trail = ["FREE TRAIL" , "MONTHLY"]
    
    var monthAndWeek = [String]()
    var forDay = [String]()
    var condition = [String]()
    var trail = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       // saveUserInfoToFirestore()
        loadSubscriptionDataFromFirestore()
    }

    @IBAction func continueBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func signOutBtn(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

extension SubcriptionViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubcriptionTableViewCell", for: indexPath) as? SubcriptionTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell here if needed
        cell.labelMonth_week.text = monthAndWeek[indexPath.row]
        cell.termConditionLbl.text = condition[indexPath.row]
        cell.for30DaysLbl.text = forDay[indexPath.row]
        cell.freeTrailBtn.setTitle(trail[indexPath.row], for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func loadSubscriptionDataFromFirestore() {
          let db = Firestore.firestore()
          
          db.collection("subscription").getDocuments { (snapshot, error) in
              if let error = error {
                  print("Error fetching subscriptions: \(error.localizedDescription)")
                  return
              }
              
              guard let snapshot = snapshot else {
                  print("Error: Snapshot is nil.")
                  return
              }
              
              self.trail.removeAll()
              self.monthAndWeek.removeAll()
              self.forDay.removeAll()
              self.condition.removeAll()
              
              for document in snapshot.documents {
                  let data = document.data()
                  
                  if let label = data["label"] as? String,
                     let price = data["price"] as? String,
                     let description = data["description"] as? String {
                      
                      self.trail.append(label)
                      self.monthAndWeek.append(price)
                      self.forDay.append(description)
                      self.condition.append("Terms & Conditions apply")
                      
                      // Print fetched data
                      print("Fetched data: \(label), \(price), \(description)")
                  } else {
                      print("Error: Missing data in document \(document.documentID)")
                  }
              }
              
              DispatchQueue.main.async {
                  self.tableView.reloadData()
              }
          }
      }

    
    
    
    
    
    /*
 
    func saveUserInfoToFirestore() {
        let db = Firestore.firestore()
        db.collection("subscription").document("monthly").setData([
            "id": "monthly",
            "label": "MONTHLY",
            "price": "₹ 300 / Month",
            "description": "Unlimited Access\nTerms & Conditions apply",
            "selected": false
            
            
        ]) { error in
            if let error = error {
                print("Error saving user info to Firestore: \(error.localizedDescription)")
            } else {
                print("User info successfully saved to Firestore.")
            }
        }
    }
    */
    
       }



















/*
 
 func loadSubscriptionData() {
     if let path = Bundle.main.path(forResource: "subcriptionJson", ofType: "json") {
         do {
             let data = try Data(contentsOf: URL(fileURLWithPath: path))
             let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
             if let options = json?["options"] as? [[String: Any]] {
                 self.parseOptions(options)
             }
         } catch {
             print("Error loading JSON: \(error.localizedDescription)")
         }
     } else {
         print("JSON file not found")
     }
 }
 
 func parseOptions(_ options: [[String: Any]]) {
     self.monthAndWeek.removeAll()
     self.forDay.removeAll()
     self.condition.removeAll()
     self.trail.removeAll()
     
     for option in options {
         if let label = option["label"] as? String,
            let price = option["price"] as? String,
            let description = option["description"] as? String {
             
             self.trail.append(label)
             self.monthAndWeek.append(price)
             self.forDay.append(description)
             self.condition.append("Terms & Conditions apply") // Or extract if available
         }
     }
 }
 */
