//
//  MenuView.swift
//  AddressBook
//
//  Created by differenz167 on 02/04/21.
//

import SwiftUI

struct MenuView: View
{
    @State var showMenu = false

    var body: some View
    {
        let drag = DragGesture()
            .onEnded
            {
                if $0.translation.width < -100
                {
                    withAnimation
                    {
                        self.showMenu = false
                    }
                }
            }
        ZStack(alignment: .leading)
        {
            return GeometryReader{
                proxy in
                MainView(showMenu: self.$showMenu)
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                    .offset(x: self.showMenu ? proxy.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if showMenu
                {
                    MainMenuView()
                        .frame(width: proxy.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
        }.gesture(drag)
    }
}

struct MainView: View
{
    @Binding var showMenu: Bool
    
    var body: some View
    {
        Button(action:
                {
                    withAnimation {
                        self.showMenu = true
                    }
                }
                ,label:
                    {
                        Text("Show Menu")
                            .font(.largeTitle)
                    })
    }
}

struct MainMenuView: View
{
    var body: some View
    {
        VStack(alignment:.leading)
        {
                HStack
                {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 50)
                HStack
                {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Messages")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 30)
                HStack
                {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Settings")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 30)
                Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
