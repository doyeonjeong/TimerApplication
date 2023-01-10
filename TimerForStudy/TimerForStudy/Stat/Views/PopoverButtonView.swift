//
//  PopoverButtonView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI

/// TotalStatView popover View
struct PopoverButtonView: View {
    let stat: Stat
    @State private var showingPopover = false
    
    var body: some View {
        Button(action: {
            showingPopover.toggle()
        }, label: {
            Image(systemName: "plus.app")
        })
        .padding(LayoutConstants.padding)
        .popover(isPresented: $showingPopover) {
            TotalStatView(stat: stat)
        }
    }
}

private enum LayoutConstants {
    static let padding: CGFloat = 8
}

struct PopoverButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverButtonView(stat: statRawData)
    }
}
