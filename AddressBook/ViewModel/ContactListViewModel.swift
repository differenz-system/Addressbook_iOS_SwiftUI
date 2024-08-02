//
//  ContactListViewModel.swift
//  AddressBook
//
//  Created by differenz148 on 02/08/24.
//

import Foundation

public class ContactListViewModel: ObservableObject {
    
    //MARK: - Variables
    @Published var mainDictData: [ContactModel] = []
    @Published var dictData: [ContactModel] = []
    let mainContactsList = IdentifiableKeys.header.sectionHeader
    @Published var contactsList = IdentifiableKeys.header.sectionHeader
    
    @Published var searchText = ""
    
    func getData(a: [ContactList]) {
        let array = a.compactMap({ $0.name })
        
        self.dictData = a.compactMap({ ContactModel(isActive: $0.isActive, name: $0.name ?? "", mail: $0.mail ?? "", mobileno: $0.mobileno ?? "") })
        self.mainDictData = self.dictData
        print(self.dictData)
    }
    
    func searchContact() {
        if self.searchText == "" {
            self.dictData = self.mainDictData
            self.contactsList = self.mainContactsList
        } else {
            self.dictData = self.mainDictData.filter({ $0.name.lowercased().contains(self.searchText.lowercased()) })
            
            var contact: [String] = []
            let firstCharOfContact = self.dictData.map({ $0.name.lowercased().first })
            for data in self.mainContactsList {
                if firstCharOfContact.contains(data.lowercased().first), !contact.contains("\(data.lowercased().first)") {
                    contact.append(data)
                }
            }
            self.contactsList = contact
        }
    }
}
