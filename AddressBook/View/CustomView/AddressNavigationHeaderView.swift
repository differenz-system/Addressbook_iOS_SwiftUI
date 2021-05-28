//
//  AddressNavigationHeaderView.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI

struct AddressNavigationHeaderView: View
{
    var body: some View
    {
        VStack
        {
            HStack
            {
                Image(IdentifiableKeys.ImageName.kic_background_header)
                    .resizable()
                    .scaledToFill()
                    .overlay(AddressNavigationHeaderView(imageTextAddressVM: NavigationHeaderViewModel()))
                    .frame(height: 180)
                    .mask(CustomShapeView(radius: 30))
            }
        }
        .frame(height:180)
    }
}

struct MySearchBar : View
{
    @Binding var search: String
    var body: some View{
        VStack
        {
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

struct AddressNavigationHeaderView: View
{
    @StateObject var imageTextAddressVM: NavigationHeaderViewModel
    
    var body: some View
    {
        ZStack
        {
            NavigationLink(destination: ContactDetailView(isProfileEdit: false, name: $imageTextAddressVM.name, email: $imageTextAddressVM.email, mobile: $imageTextAddressVM.mobile), tag: imageTextAddressVM.kBack, selection: $imageTextAddressVM.isBackPressed)
            {
                EmptyView()
            }
            NavigationLink(destination: LoginView(loginVM: LoginViewModel()), tag: imageTextAddressVM.kBack1, selection: $imageTextAddressVM.isBackPressed1)
            {
                EmptyView()
            }
            VStack
            {
                HStack
                {
                    Image(IdentifiableKeys.ImageName.kic_logout)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width:30,height:30)
                        .multilineTextAlignment(.leading)
                        .onTapGesture
                        {
                            imageTextAddressVM.isBackPressed1 = imageTextAddressVM.kBack1
                        }
                    
                    Spacer()
                    
                    Image(IdentifiableKeys.ImageName.kic_add)
                        .resizable()
                        .frame(width:30,height:30)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .onTapGesture
                        {
                            imageTextAddressVM.isBackPressed = imageTextAddressVM.kBack
                        }
                }.padding(.horizontal, 30)
                
                Text(IdentifiableKeys.Labels.kAddressBook)
                               .font(.system(size: 25))
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                
            }
            .padding(.bottom,20)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        AddressNavigationHeaderView()
        
    }
}
