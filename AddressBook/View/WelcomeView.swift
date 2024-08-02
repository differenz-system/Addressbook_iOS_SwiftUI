//
//  WelcomeView.swift
//  HailBooks
//
//  Created by Pooja Sadariwala on 26/02/24.
//

import SwiftUI

struct WelcomeView: View {
    
    //MARK: - Variables
    @EnvironmentObject private var viewRouters : ViewRouter<AppPage>
    
    var body: some View {
        VStack {
            NavigationStack(path: self.$viewRouters.path) {
                self.viewRouters.build(page: self.viewRouters.root)
                ///`Navigate to the destination view`
                    .navigationDestination(for: AppPage.self, destination: { page in
                        self.viewRouters.build(page: page)
                    })
            }
            .shadow(color: Color.clear, radius: 0)
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
