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
                .frame(width: LayoutConstants.profileImageLength,
                       height: LayoutConstants.profileImageLength)
            
            Text(friend.name)
            
            Spacer()
            
            Button(action: { friend.isPeeping.toggle() }) {
                if friend.isAccessEnabled && friend.isPeeping {
                    Image(systemName: TextConstants.eyesIconName)
                        .foregroundColor(.blue)
                } else if friend.isAccessEnabled && !friend.isPeeping {
                    Image(systemName: TextConstants.eyesIconName)
                        .foregroundColor(.gray)
                } else {
                    Image(systemName: TextConstants.xCircleiconName)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

private enum LayoutConstants {
    static let profileImageLength: CGFloat = 50
}

private enum TextConstants {
    static let eyesIconName = "eyes"
    static let xCircleiconName = "x.circle"
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: .constant(.init(name: "김동욱", image: Image("User1"), isAccessEnabled: true, isPeeping: true)))
    }
}
