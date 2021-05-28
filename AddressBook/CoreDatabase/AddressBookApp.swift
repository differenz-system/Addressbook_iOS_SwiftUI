//
//  AddressBookApp.swift
//  AddressBook
//
//  Created by differenz167 on 30/03/21.
//

import SwiftUI
import CoreData

@main
struct AddressBookApp: App {
    @Environment(\.managedObjectContext) var managedObjectContext

    let persistenceController = PersistenceController.shared

    var body: some Scene
    {
        WindowGroup
        {
            LoginView(loginVM: LoginViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
   
}
