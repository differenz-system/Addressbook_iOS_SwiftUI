//
//  IdentifierConstant.swift
//  AddressBook
//
//  Created by differenz94 on 31/03/21.
//

import Foundation

struct IdentifiableKeys {
    
    struct Labels {
        static let kEmail                        = "Email"
        static let kPassword                     = "Password"
        static let kContactNumber                = "Contact Number"
        static let kName                         = "Name"
        static let kActive                       =  "Active"
        static let kLogin                        = "Login"
        static let kDetail                       = "Detail"
        static let kLgoinDesc                    = "Enter your username and password"
        static let kOr                           = "Or"
        static let kAddressBook                  = "Address Book"
        static let kOK                           = "OK"

        
    }
    struct Placeholders{
        static let kPEmail                       = "Email goes here"
        static let kPPassword                    = "Password goes here"
        static let kPSearch                      = "Search name..."
        static let kPName                        = "Name goes here"
        static let kPContactNumber               = "Contact number goes here"
    }
    
    struct Buttons {
        
        //Alert Buttons
        static let kOK                          = "OK"
        static let kDONE                        = "DONE"
        static let kDone                        = "Done"
        
        //Authentication
        static let kLOGIN                       = "Log In"
        static let kFBLogin                     = "Login with Facebook"
        
        //New Record
        static let kSave                        = "Save"
        static let kCancel                      = "Cancel"
        
        //Update Record
        static let kUpdate                      = "Update"
        static let kDelete                      = "Delete"
    }
    
    struct ImageName {
        //Login
        static let kic_background_header        = "ic_background_header"
        static let kic_facebook                 = "ic_facebook"
        
        //Add
        static let kic_add                      = "ic_add"
        
        //List
        static let kic_list                     = "ic_list"
        
        //Logout
        static let kic_logout                   = "ic_logout"
        
    }
    
    struct ValidationMessages {
        
        //Authentication
        static let kEmptyUserName               = "Please enter username."
        static let kInvalidUserName             = "Please enter valid username."
        static let kEmptyPassword               = "Please enter password."
        static let kInvalidPassword             = "Password should contain at least 6 characters."
        
        
        //New Record
        static let kEmptyEmail                  = "Please enter email."
        static let kInvalidEmail                = "Please enter valid email."
        static let kEmptyContactNumber          = "Please enter contact number."
        static let kInvalidContactNumber        = "Please enter valid contact number."
        
        //Delete Record
        static let kDeleteRecord                = "Are you sure you want to delete this Record?"
        
    }
    
    struct ValidationFormat{
        
        //Email Format
        static let kEmailRegex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        //Contact Number Format
        static let kPhoneRegex = "^[6-9]\\d{9}$"
    }
    
    struct header{
        static let sectionHeader = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z"]
    }
}
