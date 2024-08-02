//
//  CustomNavigationView.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI

struct MySearchBar : View {
    @Binding var search: String
    var body: some View {
        VStack {
            TextField(IdentifiableKeys.Placeholders.kPSearch, text: $search)
                .padding(.horizontal,20)
                .frame(height:50)
                .background(Color.white)
                .cornerRadius(20)
        }
        .padding(.horizontal, 50)
        .offset(x: 0, y: -30)
    }
}

struct CustomNavigationView: View {
    
    var body: some View {
        VStack {
            HStack {
                Image(IdentifiableKeys.ImageName.kic_background_header)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .mask(CustomShapeView(radius: 30))
            }
        }
        .frame(height:180)
    }
}

struct navigationForLogin: View {
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

struct navigationForAddressList: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(IdentifiableKeys.ImageName.kic_logout)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width:30,height:30)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            self.viewRouters.popToRoot()
                            self.viewRouters.updateRoot(to: .login)
                        }
                    
                    Spacer()
                    
                    Image(IdentifiableKeys.ImageName.kic_add)
                        .resizable()
                        .frame(width:30,height:30)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            self.viewRouters.push(page: .contactDetail(isForEdit: false, contactData: nil))
                        }
                }
                .padding(.horizontal, 30)
                
                Text(IdentifiableKeys.Labels.kAddressBook)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
            .padding(.bottom,20)
        }
    }
}

struct navigationForDetail: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.viewRouters.pop()
                    })
                    {
                        Image(IdentifiableKeys.ImageName.kic_list)
                            .resizable()
                            .frame(width:40,height:40)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.viewRouters.updateRoot(to: .login)
                        self.viewRouters.popToRoot()
                    })
                    {
                        Image(IdentifiableKeys.ImageName.kic_logout)
                            .resizable()
                            .frame(width:30,height:30)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.horizontal, 25)
                
                Text(IdentifiableKeys.Labels.kDetail)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
            .padding(.bottom,30)
        }
    }
}
