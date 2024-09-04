//
//  NetworkingHelper.swift
//  LUDIAN
//
//  Created by mac on 28/05/24.
//

import Foundation
import UIKit

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func sendMultipartFormDataRequest(with parameters: [[String: Any]], url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        for param in parameters {
            let paramName = param["key"] as! String
            let paramValue = param["value"] as! String
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(paramName)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(paramValue)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
    }
}
