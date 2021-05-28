//
//  ContactDetailView.swift
//  AddressBook
//
//  Created by differenz94 on 16/03/21.
//  Copyright © 2021 differenz94. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactDetailView: View
{
    @State var isProfileEdit : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: ContactList.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ContactList.name, ascending: true)
        ]
    )
    var cList: FetchedResults<ContactList>
    
    @State private var isToggle : Bool = false
    @Binding var name: String
    @Binding var email: String
    @Binding var mobile: String
    
    @State private var showingAlert = false
    @State private var showingDelAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader { geo in
                VStack {
                    VStack(alignment: .leading)
                    {
                        Image(IdentifiableKeys.ImageName.kic_background_header)
                            .resizable()
                            .scaledToFill()
                            .overlay(NavigationHeaderView(closeAction: {
                                presentationMode.wrappedValue.dismiss()
                            }), alignment: .center)
                            .frame(height: geo.size.height/4)
                            .mask(CustomShapeView(radius: 30))
                    }
                    
                    Spacer().frame(height: geo.size.height/20)
                    ScrollView (.vertical, showsIndicators: false)
                    {
                        VStack(alignment: .leading, spacing: 20)
                        {
                            VStack(alignment: .leading,spacing: 20)
                            {
                                //Name
                                Text(IdentifiableKeys.Labels.kName)
                                    .font(.callout)
                                    .bold()
                                
                                TextField(IdentifiableKeys.Placeholders.kPName, text: $name)
                                    .frame(height: 40)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .border(Color.black, width: 2)
                                    .cornerRadius(5)
                                    .shadow(radius: 5, x: 0, y: 5)
                                
                                //Email
                                Text(IdentifiableKeys.Labels.kEmail)
                                    .font(.callout)
                                    .bold()
                                
                                TextField(IdentifiableKeys.Placeholders.kPEmail, text: $email)
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
                                
                                TextField(IdentifiableKeys.Placeholders.kPContactNumber, text: $mobile)
                                    .frame(height: 40)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .border(Color.black, width: 2)
                                    .cornerRadius(5)
                                    .shadow(radius: 5, x: 0, y: 5)
                                
                            }.padding(.horizontal, 30)
                            
                            HStack (spacing: 20){
                                Text(IdentifiableKeys.Labels.kActive)
                                    .font(.callout)
                                    .bold()
                                Toggle("", isOn: self.$isToggle).labelsHidden()
                            }
                            .padding(.horizontal, 30)
                            
                            Button(action:
                                    {
                                        if isValidUserinput()
                                        {
                                            self.addContact(name:name,mail:email,mobile:mobile)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    })
                            {
                                Text( self.isProfileEdit ? IdentifiableKeys.Buttons.kUpdate : IdentifiableKeys.Buttons.kSave)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .alert(isPresented: $showingAlert)
                            {
                                Alert(title: Text(errorMessage),
                                      message: Text(""))
                            }
                            .frame(width: geo.size.width/1.20, height: geo.size.height / 15)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(gradient:
                                                        Gradient(colors:
                                                                    [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]),
                                                       startPoint: .leading, endPoint: .trailing)))
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            .padding(.horizontal, 30)
                            
                            Button(action:
                                    {
                                        if self.isProfileEdit==true
                                        {
                                            showingDelAlert=true
                                        }
                                        else
                                        {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    })
                            {
                                Text(self.isProfileEdit ? IdentifiableKeys.Buttons.kDelete : IdentifiableKeys.Buttons.kCancel)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .alert(isPresented: $showingDelAlert)
                            {
                                Alert(title: Text(IdentifiableKeys.ValidationMessages.kDeleteRecord),
                                      message: Text(""),
                                      primaryButton: .default (Text(IdentifiableKeys.Labels.kOK))
                                        {
                                            
                                            self.deleteContact(mail: email)
                                            //print("OK button tapped")
                                            self.presentationMode.wrappedValue.dismiss()
                                        },secondaryButton: .cancel())
                            }
                            .frame(width: geo.size.width/1.20, height: geo.size.height/15)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(gradient:
                                                        Gradient(colors:
                                                                    [Color.CustomColor.kLightGreen, Color.CustomColor.kDarkGreen]),
                                                       startPoint: .leading, endPoint: .trailing)))
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            
                            .padding(.horizontal, 30)
                            Spacer()
                        }
                    }
                }
                
            }
            .onAppear{
                if !isProfileEdit{
                    name = ""
                    email = ""
                    mobile = ""
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension ContactDetailView{
    
    func isValidUserinput() -> Bool
    {
        if (name.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyUserName)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kEmptyUserName
            return false
        }
        
        else if (email.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyEmail)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kEmptyEmail
            return false
        }
        
        else if (!email.isValidEmail()) {
            print(IdentifiableKeys.ValidationMessages.kInvalidEmail)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kInvalidEmail
            return false
        }
        
        else if (mobile.isEmpty) {
            print(IdentifiableKeys.ValidationMessages.kEmptyContactNumber)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kEmptyContactNumber
            return false
        }
        else if (mobile.count != 10) {
            print(IdentifiableKeys.ValidationMessages.kInvalidContactNumber)
            showingAlert = true
            errorMessage = IdentifiableKeys.ValidationMessages.kInvalidContactNumber
            return false
        }
        
        return true
    }
}

extension ContactDetailView{
    
    func deleteContact(mail: String)
    {
        
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
    
    
    func addContact(name: String, mail: String, mobile: String)
    {
        
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


