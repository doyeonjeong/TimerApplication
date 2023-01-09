//
//  FriendRow.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import SwiftUI

struct FriendRow: View {
    @ObservedObject var friend: Friend
    
    var body: some View {
        HStack {
            friend.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(friend.name)
            Spacer()
            
            Button(action: {
                friend.isFavorite.toggle()
            }, label: {
                if friend.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                }
            })
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: .init(name: "김동욱", image: Image(systemName: "person.crop.circle"), isFavorite: true))
    }
}
