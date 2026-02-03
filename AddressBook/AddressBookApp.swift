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
    
    //MARK: - Variables
    @StateObject var viewRouter : ViewRouter = ViewRouter(root: AppPage.login)
    @Environment(\.managedObjectContext) var managedObjectContext

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup
        {
            WelcomeView()
                .environmentObject(self.viewRouter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
