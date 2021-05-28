//
//  Constant.swift
//  AddressBook
//
//  Created by differenz167 on 18/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import Foundation
import SwiftUI


extension Color
{
    struct CustomColor
    {
        static let kLightGreen    = Color(#colorLiteral(red: 0.6105767488, green: 0.8227700591, blue: 0.7830751538, alpha: 1))
        static let kDarkGreen     = Color(#colorLiteral(red: 0.4307857156, green: 0.6315324903, blue: 0.6296854615, alpha: 1))
        static let kDarkBlue      = Color(#colorLiteral(red: 0.231395781, green: 0.3482967317, blue: 0.5954764485, alpha: 1))
        static let kBackColor     = Color(#colorLiteral(red: 0.9318081737, green: 0.9319420457, blue: 0.9317788482, alpha: 1))
        static let kBorderColor   = Color(#colorLiteral(red: 0.2319326401, green: 0.3797670007, blue: 0.3842396736, alpha: 1))
        
    }
    
}
class Constant{
    //MARK: - API constants
    struct serverAPI {
        
        //MARK: - API URL constants
        struct URL {
            static let kBaseURL                  = "https://postman-echo.com/"
            
            static let Login                     = kBaseURL + "post"
            
        }
        
        //MARK: - API Error Message constants
        
        struct errorMessages {
            static let kNoInternetConnectionMessage     = "Please check your internet connection."
            static let kCommanErrorMessage              = "Something went wrong please try again later."
            static let kServerErrorMessage              = "There seems to be a problem with the connection.Please try again soon."
        }
        
    }
    
    //MARK: - UserDefaults key constants
    
    struct UserDefaultsKey {
        static let IsLogin                              = "isLogin"
        static let AccFBLogin                           = "accFBLogin"
    }
}
//MARK: - API Request Paramter constants
struct RequestParamater {
    static let kEmail                                   = "email"
    static let kPassword                                = "password"
}

