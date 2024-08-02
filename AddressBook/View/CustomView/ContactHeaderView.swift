//
//  ContactHeaderView.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI

struct ContactHeaderView: View {
    var header:String
    
    var body: some View {
        HStack {
            Text(header).fontWeight(.bold)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width , height:35,alignment:.leading)
        .background(LinearGradient(gradient: Gradient(colors: [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]), startPoint: .leading, endPoint: .trailing))
    }
}
