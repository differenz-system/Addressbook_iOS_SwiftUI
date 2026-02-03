//
//  AddressList.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI
import CoreData

struct AddressList: View {
    
    //MARK: - Variables
    @State var contactListVM: ContactListViewModel = ContactListViewModel()
    @FetchRequest(entity: ContactList.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \ContactList.name, ascending: true)])
    var cList: FetchedResults<ContactList>
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationView()
                .overlay(navigationForAddressList(), alignment: .center)
            
            MySearchBar(search: self.$contactListVM.searchText)
                .onChange(of: self.contactListVM.searchText) { _, _ in
                    self.contactListVM.searchContact()
                }
            
            ScrollView(.vertical,showsIndicators:false)  {
                ScrollViewReader { value in
                    
                    ZStack {
                        VStack {
                            if self.contactListVM.contactsList.count > 0 {
                                ForEach(0..<self.contactListVM.contactsList.count) { i in
                                    if i < self.contactListVM.contactsList.count {
                                        ContactHeaderView(header: self.contactListVM.contactsList[i])
                                        
                                        Spacer()
                                            .frame(height:10)
                                        
                                        //Using Dictionary
                                        ForEach(self.contactListVM.dictData.filter { $0.name.hasPrefix(self.contactListVM.contactsList[i]) }, id: \.self) { vals in
                                            ContactCellView(detail: vals)
                                        }
                                        
                                        Spacer()
                                            .frame(height:10)
                                    } else {
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.contactListVM.getData(a: self.cList.map({ $0 }))
            self.contactListVM.searchText = ""
            self.contactListVM.searchContact()
        }
        .background(Color.CustomColor.kBackColor)
    }
}
