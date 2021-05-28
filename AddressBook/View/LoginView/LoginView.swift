//
//  LoginView.swift
//  AddressBook
//
//  Created by differenz94 on 16/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI
import CoreData
import FBSDKLoginKit
import FirebaseAuth

struct LoginView: View
{
    //var userLoginManager = UserLoginManager()
    @StateObject var loginVM: LoginViewModel
    let loginManager = LoginManager()
    @State var navigation: String? = nil


    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                NavigationLink(destination: AddressList(), tag: loginVM.kBack, selection: $loginVM.isBackPressed) {
                    EmptyView()
                }
                
                GeometryReader { geo in
                    VStack
                    {
                        VStack(alignment: .leading)
                        {
                            Image(IdentifiableKeys.ImageName.kic_background_header)
                                .resizable()
                                .scaledToFill()
                                .overlay(ImageTextLogin(), alignment: .center)
                                .frame(height: geo.size.height/4)
                        }
                        .mask(CustomShapeView(radius: 30))
                        
                        Spacer().frame(height: geo.size.height/20)
                        ScrollView
                        {
                            VStack(alignment: .leading, spacing: 20)
                            {
                                VStack(alignment: .leading,spacing: 20)
                                {
                                    Text(IdentifiableKeys.Labels.kEmail)
                                        .font(.callout)
                                        .bold()
                                    TextField(IdentifiableKeys.Placeholders.kPEmail, text: $loginVM.username)
                                        
                                        .frame(height: 40)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .border(Color.CustomColor.kBorderColor, width: 2)
                                        .cornerRadius(5)
                                        .shadow(radius: 5, x: 0, y: 5)
                                }
                                .padding(.horizontal, 15)
                                
                                VStack(alignment: .leading,spacing: 20)
                                {
                                    Text(IdentifiableKeys.Labels.kPassword)
                                        .font(.callout)
                                        .bold()
                                    SecureField(IdentifiableKeys.Placeholders.kPPassword, text: $loginVM.password)
                                        
                                        .frame(height: 40)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .border(Color.CustomColor.kBorderColor, width: 2)
                                        .cornerRadius(5)
                                        .shadow(radius: 5, x: 0, y: 5)
                                }
                                .padding(.horizontal, 15)
                            }.padding(.horizontal, 15)
                            Spacer().frame(height: geo.size.height/7)
                            
                            VStack (spacing: 30)
                            {
                                Button(action:
                                        {
                                            self.loginVM.btnLogin_Click()
                                            
                                        })
                                {
                                    Text(IdentifiableKeys.Buttons.kLOGIN)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: geo.size.width/1.20, height: geo.size.height / 15)
                                        .background(
                                            Capsule()
                                                .fill(
                                                    LinearGradient(gradient:
                                                                    Gradient(colors:
                                                                                [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]),
                                                                   startPoint: .leading, endPoint: .trailing)
                                                )
                                                .shadow(color: .gray, radius: 5, x: 0, y: 5))
                                        
                                        .padding(.horizontal, 30)
                                }.alert(isPresented: $loginVM.showingAlert) {
                                    Alert(title: Text(loginVM.errorMessage), message: Text(""))
                                }
                                
                                Text(IdentifiableKeys.Labels.kOr)
                                    .bold()
                                    .padding(.horizontal,10)
                                
                                Button(action:
                                        {
                                            self.facebookLogin()
                                        }
                                )
                                {
                                    HStack(spacing: 20) {
                                        Image(IdentifiableKeys.ImageName.kic_facebook)
                                            .foregroundColor(.white)
                                        
                                        Text(IdentifiableKeys.Buttons.kFBLogin)
                                            .font(.system(size: UIScreen.main.bounds.height/40))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: UIScreen.main.bounds.width/1.20, height: UIScreen.main.bounds.height/15)
                                    .background(
                                        Capsule()
                                            .fill(Color.CustomColor.kDarkBlue))
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }
        .progressHUD(isShowing: $loginVM.showLoadingIndicator)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


extension LoginView{
    
    // Facebook Login API Call
    func facebookLogin()
    {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil)
        {
            loginResult in
            switch loginResult
            {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(String(describing: accessToken))")
                
                loginVM.isBackPressed = loginVM.kBack
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil)
                    {
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                    }
                })
            }
        }
    }
    
           
    
}


struct ImageTextLogin: View {
    var body: some View {
        ZStack {
            Text(IdentifiableKeys.Labels.kLogin)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(6)
                .foregroundColor(.white)
        }
        .padding(6)
    }
}


struct LoginView_Previews: PreviewProvider
{
    static var previews: some View
    {
        LoginView(loginVM: LoginViewModel())
    }
}
