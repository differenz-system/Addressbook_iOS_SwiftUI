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

struct LoginView: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    CustomNavigationView()
                        .overlay(navigationForLogin(), alignment: .center)
                    
                    Spacer()
                        .frame(height: geo.size.height/20)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading,spacing: 20) {
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
                        
                        VStack(alignment: .leading,spacing: 20) {
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
                    }
                    .padding(.horizontal, 15)
                    
                    Spacer()
                        .frame(height: geo.size.height/7)
                    
                    VStack (spacing: 30) {
                        Button(action: {
                            self.loginVM.btnLogin_Click(success: {
                                self.viewRouters.popToRoot()
                                self.viewRouters.updateRoot(to: .addressList)
                            })
                        }) {
                            Text(IdentifiableKeys.Buttons.kLOGIN)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: geo.size.width/1.20, height: geo.size.height / 15)
                                .background(Capsule()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]), startPoint: .leading, endPoint: .trailing))
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5))
                            
                                .padding(.horizontal, 30)
                        }
                        .alert(isPresented: $loginVM.showingAlert) {
                            Alert(title: Text(loginVM.errorMessage), message: Text(""))
                        }
                        
                        Text(IdentifiableKeys.Labels.kOr)
                            .bold()
                            .padding(.horizontal,10)
                        
                        Button(action: {
                            self.loginVM.facebookLogin {
                                self.viewRouters.popToRoot()
                                self.viewRouters.updateRoot(to: .addressList)
                            }
                        }) {
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
            .edgesIgnoringSafeArea(.top)
        }
        .progressHUD(isShowing: $loginVM.showLoadingIndicator)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View
    {
        LoginView(loginVM: LoginViewModel())
    }
}
