//
//  DetailViewModel.swift
//  AddressBook
//
//  Created by differenz148 on 02/08/24.
//

import Foundation

@Observable
public class DetailViewModel {
    
    //MARK: - Variables
    var isToggle : Bool = false
    var name: String = ""
    var email: String = ""
    var mobile: String = ""
    
    var showingAlert = false
    var showingDelAlert = false
    var errorTitle = ""
    var errorMessage = ""
    
    func isValidUserinput() -> Bool {
        if (self.name.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyUserName)
            self.showingAlert = true
            self.errorMessage = IdentifiableKeys.ValidationMessages.kEmptyUserName
            return false
        } else if (self.email.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyEmail)
            self.showingAlert = true
            self.errorMessage = IdentifiableKeys.ValidationMessages.kEmptyEmail
            return false
        } else if (!self.email.isValidEmail()) {
            print(IdentifiableKeys.ValidationMessages.kInvalidEmail)
            self.showingAlert = true
            self.errorMessage = IdentifiableKeys.ValidationMessages.kInvalidEmail
            return false
        } else if (self.mobile.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyContactNumber)
            self.showingAlert = true
            self.errorMessage = IdentifiableKeys.ValidationMessages.kEmptyContactNumber
            return false
        } else if (self.mobile.count != 10) {
            print(IdentifiableKeys.ValidationMessages.kInvalidContactNumber)
            self.showingAlert = true
            self.errorMessage = IdentifiableKeys.ValidationMessages.kInvalidContactNumber
            return false
        }
        
        return true
    }
}
