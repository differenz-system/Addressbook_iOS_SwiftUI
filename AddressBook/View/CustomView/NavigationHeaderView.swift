//
// NavigationHeaderView.swift
//  AddressBook
//
//  Created by differenz94 on 01/04/21.
//

import SwiftUI

struct NavigationHeaderView: View
{
    @State var kBack = "back"
    @State var isBackPressed: String?=nil
    
    @State var kLoginBack = "back"
    @State var isLoginBackPressed: String?=nil
    @Environment(\.presentationMode) private var presentationMode
    let closeAction: () -> Void
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                NavigationLink(destination: LoginView(loginVM: LoginViewModel()), tag: kLoginBack, selection: $isLoginBackPressed) {
                    EmptyView()
                }
                HStack
                {
                    Button(action:
                            {
                                //print("Back To Address Book")
                                closeAction()
                            })
                    {
                        Image(IdentifiableKeys.ImageName.kic_list)
                            .resizable()
                            .frame(width:40,height:40)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Button(action:
                            {
                                self.isLoginBackPressed = kLoginBack
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

