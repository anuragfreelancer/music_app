//
//  ImageExtensions.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation
import UIKit

extension UIImage{
    
   static func loadUrlImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = URL(string: urlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }

}
