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

public class LoginViewModel: ObservableObject {
    
    //MARK: - Variables
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var showingAlert = false
    @Published var errorMessage : String = ""
    @Published var showingError = false
    @Published var showLoadingIndicator = false
    
//    let loginManager = LoginManager()
    
    @Environment(\.managedObjectContext) var managedObjectContext
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
    
//    Facebook Login API Call
//    func facebookLogin(success: @escaping () -> ()) {
//        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) {
//            loginResult in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(String(describing: accessToken))")
//                success()
//                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
//                    if (error == nil)
//                    {
//                        let fbDetails = result as! NSDictionary
//                        print(fbDetails)
//                    }
//                })
//            }
//        }
//    }
}
