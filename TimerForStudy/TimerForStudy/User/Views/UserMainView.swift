//
//  UserMainView.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/10.
//

import SwiftUI

struct UserMainView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("MyProfile")) {
                ZStack {
                    Color.green
                    Text("UserMainView")
                }
            }
        }
    }
}

struct UserMainView_Previews: PreviewProvider {
    static var previews: some View {
        UserMainView()
    }
}
