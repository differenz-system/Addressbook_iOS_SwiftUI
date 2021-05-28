//
//  NavigationHeaderViewModel.swift
//  AddressBook
//
//  Created by differenz94 on 01/04/21.
//

import SwiftUI

public class NavigationHeaderViewModel: ObservableObject{
    @Published var kBack="back"
    @Published var isBackPressed: String?=nil
    @Published var kBack1="back"
    @Published var isBackPressed1: String?=nil
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var mobile: String = ""
}

extension NavigationHeaderViewModel{
    
    func navToDetail_Click() {
        self.isBackPressed = self.kBack
    }
    
    func navToLogin_Click() {
        self.isBackPressed1 = self.kBack1
    }
}
