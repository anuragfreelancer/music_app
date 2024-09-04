//
//  ColorManager.swift
//  LUDIAN SELLER
//
//  Created by mac on 15/07/24.
//

import UIKit


class ColorManager {
    
    // Define your custom colors here
    static var themeColor: UIColor = UIColor(red: 136, green: 179/255.0, blue: 89, alpha: 1.0) // Default theme color
    
    static let primaryColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0) // Example color
    static let secondaryColor = UIColor(red: 1.0, green: 149.0/255.0, blue: 0.0, alpha: 1.0) // Example color
    
    // You can add more colors as needed
    
    static func setThemeColor(_ color: UIColor) {
        themeColor = color
    }
    
    static func getThemeColor() -> UIColor {
        return themeColor
    }
    
    static func color(from name: String) -> UIColor? {
        switch name {
        case "primary":
            return primaryColor
        case "secondary":
            return secondaryColor
        // Add more cases for additional colors
        default:
            return nil
        }
    }
}

