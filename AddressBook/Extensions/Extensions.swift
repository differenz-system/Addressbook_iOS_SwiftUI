//
//  Extensions.swift
//  AddressBook
//
//  Created by differenz94 on 31/03/21.
//

import SwiftUI
import Foundation

extension String{
    
    func isValidUsername() -> Bool {
        // Length be 14 characters max and 3 characters minimum.
        let RegEx = "\\A\\w{3,12}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
       
        let emailFormat = IdentifiableKeys.ValidationFormat.kEmailRegex
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        // Length be 8 characters minimum.
        guard self.count >= 6 else {
            return false
        }
        return true
    }
    
    func isValidContactNumber() -> Bool {
        let PHONE_REGEX = IdentifiableKeys.ValidationFormat.kPhoneRegex
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluate(with: self)
        
    }
}
