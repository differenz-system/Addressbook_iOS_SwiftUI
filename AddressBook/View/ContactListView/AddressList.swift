//
//  AddressList.swift
//  AddressBook
//
//  Created by differenz167 on 19/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI
import CoreData

struct AddressList: View
{
    @State var filter: String = ""
    
    @FetchRequest(
        
        entity: ContactList.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ContactList.name, ascending: true)
        ]
    )
    var cList: FetchedResults<ContactList>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var arrName: [String] = []
    @State var dictData: [ContactList] = []
    
    let contactsList = IdentifiableKeys.header.sectionHeader
    
    
    @State private var searchText = ""
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader
            {
                proxy in
                VStack(spacing: 0.0)
                {
                    AddressNavigationHeaderView()
                    MySearchBar(search: self.$searchText)
                    ScrollView(.vertical,showsIndicators:false)
                    {
                        ScrollViewReader
                        {
                            value in
                            
                            ZStack
                            {
                                VStack
                                {
                                    ForEach(0..<contactsList.count)
                                    {
                                        i in
                                        ContactHeaderView(header:contactsList[i])
                                        Spacer().frame(height:10)
                                        
                                        //Using Dictionary
                                        ForEach(dictData.filter {
                                                    ($0.name?.hasPrefix(contactsList[i]) ?? false) }, id: \.self)
                                        {
                                            vals in
                                            ContactCellView(contactCellVM: ContactCellViewModel(), dName : vals.name ?? "",dMail : vals.mail ?? "",dMobile : vals.mobileno ?? "")
                                        }
                                        Spacer().frame(height:10)
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear
                {
                    self.getData()
                }
                .background(Color.CustomColor.kBackColor)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            .listStyle(GroupedListStyle())
            
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension AddressList{
    func getData ()
    {
        //print(cList)
        let a = self.cList.map({ $0 })
        let array = a.compactMap({ $0.name })
        arrName = array
        //print(arrName)
        
        dictData = a.compactMap({ $0 })
        print(dictData)
    }
}
