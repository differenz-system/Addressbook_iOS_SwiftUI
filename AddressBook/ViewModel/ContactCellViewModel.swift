//
//  ContactCellViewModel.swift
//  AddressBook
//
//  Created by differenz94 on 01/04/21.
//

import SwiftUI

public class ContactCellViewModel: ObservableObject {
    @Published var kBack="back"
    @Published var isBackPressed: String?=nil
    
}

extension ContactCellViewModel {
    
    func navToDetail_Click() {
        self.isBackPressed = self.kBack
    }
}
