//
//  ContactCellView.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI

// Display Individual data in Cell Like dName,dMail,dMobile

struct ContactCellView: View
{
    @StateObject var contactCellVM: ContactCellViewModel
    @State var dName:String
    @State var dMail:String
    @State var dMobile:String

    @State var name : String=""

    var body: some View
    {
        HStack
        {
            NavigationLink(destination: ContactDetailView(isProfileEdit: true,name: $dName,email: $dMail,mobile: $dMobile), tag: contactCellVM.kBack, selection: $contactCellVM.isBackPressed)
            {
                EmptyView()
            }
            
            Button(action:
                    {
                        contactCellVM.navToDetail_Click()
                        
            }, label: {
                Rectangle()
                    .fill(LinearGradient(gradient:
                                            Gradient(colors:
                                                        [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]),
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(width:10)
                VStack(alignment: .leading, spacing:5.0)
                {
                    Text("\(dName)").font(Font.body.bold())
                    Text("\(dMail)").font(.callout)
                    Text("\(dMobile)").font(.callout)
                }
                .foregroundColor(Color.black)
            })
        }
        .frame(width:UIScreen.main.bounds.size.width/1.1,height:100,alignment:.leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5, x: 5, y: 5)
        
    }
}
