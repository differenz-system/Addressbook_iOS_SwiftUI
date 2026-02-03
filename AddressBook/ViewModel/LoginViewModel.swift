//
//  LoginViewModel.swift
//  AddressBook
//
//  Created by differenz94 on 01/04/21.
//
import Foundation
import SwiftUI
import CoreData
//import FBSDKLoginKit
import FirebaseAuth

@Observable
public class LoginViewModel {
    
    //MARK: - Variables
    var username: String = ""
    var password: String = ""
    
    var showingAlert = false
    var errorMessage : String = ""
    var showingError = false
    var showLoadingIndicator = false
    
//    let loginManager = LoginManager()
}

extension LoginViewModel{
    
    func isValidUserinput() -> Bool {
        if (username.isEmpty)
        {
            print(IdentifiableKeys.ValidationMessages.kEmptyEmail)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kEmptyEmail
            return false
        }
        else if (!username.isValidEmail())
        {
            print(IdentifiableKeys.ValidationMessages.kInvalidEmail)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kInvalidEmail
            return false
        }
        else if (password.isEmpty)
        {
            print(IdentifiableKeys.ValidationMessages.kEmptyPassword)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kEmptyPassword
            return false
        }
        else if (!password.isValidPassword())
        {
            print(IdentifiableKeys.ValidationMessages.kInvalidPassword)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kInvalidPassword
            return false
        }
        return true
    }
    
    func btnLogin_Click(success: @escaping () -> ()) {
        guard self.isValidUserinput() else { return }
        //Api call
        self.callLogin {
            success()
        }
    }
   
    func callLogin(success: @escaping () -> ())  {

        var dictParam = [String : Any]()
        dictParam[RequestParamater.kEmail] = self.username
        dictParam[RequestParamater.kPassword] = self.password
        self.showLoadingIndicator = true

        APIManager.callURLStringJson(Constant.serverAPI.URL.Login, withRequest: dictParam, withSuccess: { (response) in
            self.showLoadingIndicator = false
            success()

        }, failure: { (error) in
            print(error)
            self.errorMessage = error
            self.showingError = true
            self.showLoadingIndicator = false
        }) { (err) in
            print(err)
            self.errorMessage = err
            self.showingError = true
            self.showLoadingIndicator = false
        }
    }
}
