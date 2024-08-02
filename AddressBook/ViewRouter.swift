//
//  ViewRouter.swift
//  HailBooks
//
//  Created by Pooja Sadariwala on 26/02/24.
//

import SwiftUI

/// `AppRouter`
///     - description: app router by which navigation is possible in swiftui
class ViewRouter<Page>: ObservableObject where Page: Hashable {
    
    @Published var root: Page
    @Published var path: [Page] = []
    @Published var popToPage: Page?
    
    /// `at initialization set the root view`
    init(root: Page) {
        self.root = root
    }
    
    /// `push to a specific view`
    func push(page appPage: Page) -> Void {
        self.path.append(appPage)
    }
    
    /// `pops back to previous view`
    func pop() -> Void {
        self.path.removeLast()
    }
    
    /// `pops back to a specific view`
    func pop(to appPage: Page) -> Void {
        guard let foundIdx = self.path.firstIndex(where: { $0 == appPage }) else { return }
        let idxToPop = (foundIdx ..< self.path.endIndex).count - 1
        
        self.path.removeLast(idxToPop)
    }
    
    ///`pops back to root view`
    func popToRoot() -> Void {
        self.path.removeAll()
    }
    
    /// `update root`
    func updateRoot(to root: Page) -> Void {
        self.root = root
    }
    
    /// `build app page`
    func build(page appPage: AppPage) -> AnyView {
        
        switch appPage {
            
        case .login:
            return AnyView(LoginView())
            
        case .addressList:
            return AnyView(AddressList())
            
        case .contactDetail(isForEdit: let isForEdit, contactData: let contactData):
            return AnyView(ContactDetailView(isProfileEdit: isForEdit, contactData: contactData))
        }
    }
}

/// `AppPage`
/// - description: app route in the form of enum
enum AppPage: Hashable {
    
    case login
    case addressList
    case contactDetail(isForEdit: Bool, contactData: ContactModel?)
    
    func hash(into hasher: inout Hasher) {
        
        switch self {
            
        case .login:
            hasher.combine(1)
        case .addressList:
            hasher.combine(2)
        case .contactDetail:
            hasher.combine(3)
        }
    }
    
    static func == (lhs: AppPage, rhs: AppPage) -> Bool {
        if lhs.hashValue == rhs.hashValue {
            return true
        } else {
            return false
        }
    }
}
