//
//  UIHelper.swift
//  LUDIAN
//
//  Created by mac on 28/05/24.
//

import Foundation
import UIKit
import ImageIO
//import SVProgressHUD
//import SwiftyGif


class UIHelper {

    static let shared = UIHelper()

    private init() {}

    func setRoundedCorners(for view: UIView, cornerRadius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat, backgroundColor: UIColor?, opacity: Float) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
        }
        
        view.layer.borderWidth = borderWidth
        
        if let backgroundColor = backgroundColor {
            view.backgroundColor = backgroundColor.withAlphaComponent(CGFloat(opacity))
        }
    }
}
// MARK: - Gif Handling Extension -

//func showProgressBar() {
//    SVProgressHUD.setBackgroundColor(UIColor.themeColor)
//    SVProgressHUD.setForegroundColor(UIColor.white)
//    SVProgressHUD.show()
//}
//
//func hideProgressBar() {
//    SVProgressHUD.dismiss()
//}

class LoadingViewController: UIViewController {

    let gifImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupGif()
    }

//    func setupGif() {
//        do {
//            let gif = try UIImage(gifName: "Vector 5@3x.gif")
//            gifImageView.setGifImage(gif, loopCount: -1)
//            gifImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            gifImageView.center = self.view.center
//            self.view.addSubview(gifImageView)
//        } catch {
//            print("Error loading GIF: \(error)")
//        }
//    }
}

extension UIColor {
    static let themeColor = UIColor(red: 135/255, green: 177/255, blue: 86/255, alpha: 1.0)
    static let grayColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
    static let lightYellowColor = UIColor(red: 231/255, green: 211/255, blue: 181/255, alpha: 1.0)
    static let selectedBackgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
}
