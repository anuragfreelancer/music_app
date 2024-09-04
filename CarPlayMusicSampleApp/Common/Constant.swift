//
//  Constant.swift
//  LUDIAN
//
//  Created by mac on 28/05/24.
//

import Foundation


//http://SERVER-PHP-8-2.TECHNORIZEN.COM/ludian/api/

enum Constant: String {
    
    
    static let BASE_SERVICE_URL = "http://SERVER-PHP-8-2.TECHNORIZEN.COM/ludian/api/"
    static let BASE_IMAGE_URL = "https://appsmsjuegos.com/uploads/images/"

    
    
    case logIn
    case signUp
    case PasswordReset
    case otpVerify
    case changePassword
    case get_profile
    case update_profile
    case get_property_recent
    case get_property_most_popular
//update-profile
    case update_notiification
    case get_about_us
    case get_privacy_policy
    case get_fqa
    case book_a_property
    case get_favourites
    case booking_status_complete
    case apply_promo_code
    case get_user_booking_list
    case promocode_get_promocode // promocode/get_promocode"
    
    public func url() -> String {
        switch self {
        case .logIn:
            return Constant.oAuthRoute(path: "Login?")
        case .signUp:
            return Constant.oAuthRoute(path: "Register")
        case .PasswordReset:
            return Constant.oAuthRoute(path: "Password-Reset")
        case .otpVerify:
            return Constant.oAuthRoute(path: "otpVerify")
        case .changePassword:
            return Constant.oAuthRoute(path: "change-password")
        case .get_profile:
            return Constant.oAuthRoute(path: "get-profile")
        case .update_profile:
            return Constant.oAuthRoute(path: "update-profile")
        case .get_property_recent:
            return Constant.oAuthRoute(path: "get_property_recent")
        case .get_property_most_popular:
            return Constant.oAuthRoute(path: "get_property_most_popular")
        case .update_notiification:
            return Constant.oAuthRoute(path: "update-notiification")
        case .get_about_us:
            return Constant.oAuthRoute(path: "get-about-us")
        case .get_privacy_policy:
            return Constant.oAuthRoute(path: "get-privacy-policy")
        case .get_fqa:
            return Constant.oAuthRoute(path: "get-fqa")
        case .book_a_property:
            return Constant.oAuthRoute(path: "book_a_property")//book_a_property
        case .get_favourites:
            return Constant.oAuthRoute(path: "get-favourites")
        case .booking_status_complete:
            return Constant.oAuthRoute(path: "booking_status_complete")
        case .apply_promo_code:
            return Constant.oAuthRoute(path: "apply_promo_code")
        case .get_user_booking_list:
            return Constant.oAuthRoute(path: "get_user_booking_list")
        case .promocode_get_promocode:
            return Constant.oAuthRoute(path: "promocode/get_promocode")
        }
    }
    //change-password
    private static func oAuthRoute(path: String) -> String {
        return Constant.BASE_SERVICE_URL + path
    }
    private static func imgAuthRoute(path: String) -> String {
        return Constant.BASE_IMAGE_URL + path
    }

}
