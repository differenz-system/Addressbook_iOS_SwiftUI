//
//  ContactCellView.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI

struct ContactModel: Hashable {
    var id = UUID().uuidString
    var isActive: Bool
    var name: String
    var mail: String
    var mobileno: String
}

struct ContactCellView: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    
    @State var detail: ContactModel

    var body: some View {
        HStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]), startPoint: .leading, endPoint: .trailing))
                .frame(width:10)
            
            VStack(alignment: .leading, spacing:5.0) {
                Text("\(self.detail.name)")
                    .font(Font.body.bold())
                
                Text("\(self.detail.mail)")
                    .font(.callout)
                
                Text("\(self.detail.mobileno)")
                    .font(.callout)
            }
            .foregroundColor(Color.black)
        }
        .frame(width:UIScreen.main.bounds.size.width/1.1,height:100,alignment:.leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5, x: 5, y: 5)
        .onTapGesture {
            self.viewRouters.push(page: .contactDetail(isForEdit: true, contactData: self.detail))
        }
    }
}
