//
//  FriendRow.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import SwiftUI

struct FriendRow: View {
    @Binding var friend: Friend
    
    var body: some View {
        HStack {
            friend.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(friend.name)
            
            Spacer()
            
            Button(action: {
                friend.isPeeping.toggle()
            }, label: {
                if friend.isPeeping {
                    Image(systemName: "eyes")
                        .foregroundColor(.black)
                }
            })
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: .constant(.init(name: "김동욱", image: Image("User1"), isPeeping: true)))
    }
}
