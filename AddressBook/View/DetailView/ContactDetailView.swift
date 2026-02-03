//
//  ContactDetailView.swift
//  AddressBook
//
//  Created by differenz94 on 16/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactDetailView: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    @State var isProfileEdit : Bool = false
    @State var contactData: ContactModel?
    @State var detailVM: DetailViewModel = DetailViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                CustomNavigationView()
                    .overlay(navigationForDetail(), alignment: .center)
                
                Spacer()
                    .frame(height: geo.size.height/20)
                
                ScrollView (.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading,spacing: 20) {
                            //Name
                            Text(IdentifiableKeys.Labels.kName)
                                .font(.callout)
                                .bold()
                            
                            TextField(IdentifiableKeys.Placeholders.kPName, text: self.$detailVM.name)
                                .frame(height: 40)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.black, width: 2)
                                .cornerRadius(5)
                                .shadow(radius: 5, x: 0, y: 5)
                            
                            //Email
                            Text(IdentifiableKeys.Labels.kEmail)
                                .font(.callout)
                                .bold()
                            
                            TextField(IdentifiableKeys.Placeholders.kPEmail, text: self.$detailVM.email)
                                .frame(height: 40)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.black, width: 2)
                                .cornerRadius(5)
                                .shadow(radius: 5, x: 0, y: 5)
                                .disabled(self.isProfileEdit==true)
                            
                            //Contact Number
                            Text(IdentifiableKeys.Labels.kContactNumber)
                                .font(.callout)
                                .bold()
                            
                            TextField(IdentifiableKeys.Placeholders.kPContactNumber, text: self.$detailVM.mobile)
                                .frame(height: 40)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.black, width: 2)
                                .cornerRadius(5)
                                .shadow(radius: 5, x: 0, y: 5)
                            
                        }
                        .padding(.horizontal, 30)
                        
                        HStack (spacing: 20) {
                            Text(IdentifiableKeys.Labels.kActive)
                                .font(.callout)
                                .bold()
                            Toggle("", isOn: self.$detailVM.isToggle).labelsHidden()
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action:
                                {
                            if self.detailVM.isValidUserinput()
                            {
                                self.addContact(name: self.detailVM.name, mail: self.detailVM.email, mobile: self.detailVM.mobile, isActive: self.detailVM.isToggle)
                                self.viewRouters.pop()
                            }
                        })
                        {
                            Text(self.isProfileEdit ? IdentifiableKeys.Buttons.kUpdate : IdentifiableKeys.Buttons.kSave)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .alert(isPresented: self.$detailVM.showingAlert)
                        {
                            Alert(title: Text(self.detailVM.errorMessage),
                                  message: Text(""))
                        }
                        .frame(width: geo.size.width/1.20, height: geo.size.height / 15)
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient:
                                                        Gradient(colors: [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]),
                                                     startPoint: .leading, endPoint: .trailing)))
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 30)
                        
                        Button(action:
                                {
                            if self.isProfileEdit==true {
                                self.detailVM.showingDelAlert = true
                            } else {
                                self.viewRouters.pop()
                            }
                        })
                        {
                            Text(self.isProfileEdit ? IdentifiableKeys.Buttons.kDelete : IdentifiableKeys.Buttons.kCancel)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .alert(isPresented: self.$detailVM.showingDelAlert) {
                            Alert(title: Text(IdentifiableKeys.ValidationMessages.kDeleteRecord),
                                  message: Text(""),
                                  primaryButton: .default (Text(IdentifiableKeys.Labels.kOK)) {
                                self.deleteContact(mail: self.detailVM.email)
                                self.viewRouters.pop()
                            },secondaryButton: .cancel())
                        }
                        .frame(width: geo.size.width/1.20, height: geo.size.height/15)
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]), startPoint: .leading, endPoint: .trailing)))
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 30)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            if isProfileEdit {
                self.detailVM.name = self.contactData?.name ?? ""
                self.detailVM.email = self.contactData?.mail ?? ""
                self.detailVM.mobile = self.contactData?.mobileno ?? ""
                self.detailVM.isToggle = self.contactData?.isActive ?? false
            }
        }
    }
}

extension ContactDetailView {
    
    func deleteContact(mail: String) {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ContactList")
        fetchRequest.predicate = NSPredicate(format: "mail = %@", mail)
        
        do {
            let fetchReturn = try managedObjectContext.fetch(fetchRequest)
            
            let objectDelete = fetchReturn[0] as! NSManagedObject
            
            managedObjectContext.delete(objectDelete)
            do {
                try managedObjectContext.save()
                //print("deleted successfully")
                
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func addContact(name: String, mail: String, mobile: String, isActive: Bool) {
        
        if isProfileEdit
        {
            print("Click Update")
            
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ContactList")
            fetchRequest.predicate = NSPredicate(format: "mail = %@", mail)
            
            do {
                let fetchReturn = try managedObjectContext.fetch(fetchRequest)
                
                let objectDelete = fetchReturn[0] as! NSManagedObject
                objectDelete.setValue(name, forKey: "name")
                objectDelete.setValue(mail, forKey: "mail")
                objectDelete.setValue(mobile, forKey: "mobileno")
                objectDelete.setValue(isActive, forKey: "isActive")
                
                do {
                    try managedObjectContext.save()
                    print("Update successfully")
                    
                } catch let error as NSError {
                    print("Could not update. \(error), \(error.userInfo)")
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        else
        {
            print("Click Add")
            let newContact = ContactList(context: managedObjectContext)
            
            newContact.name = name
            newContact.mail = mail
            newContact.mobileno = mobile
            newContact.isActive = isActive
            do
            {
                try managedObjectContext.save()
                print("Contact Record is Inserted")
            }
            catch
            {
                print("Error saving managed object context: \(error)")
            }
        }
        
    }
}


