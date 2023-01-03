//
//  PopoverButtonView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI

/// TotalStatView popover View
struct PopoverButtonView: View {
    @State private var showingPopover = false
    
    var body: some View {
        Button("Total") {
            showingPopover.toggle()
        }
        .padding(LayoutConstants.offset)
        .popover(isPresented: $showingPopover) {
            TotalStatView()
        }
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 8
}

struct PopoverButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverButtonView()
    }
}
