//
//  Friend.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation
import SwiftUI

final class Friend: ObservableObject {
    let name: String
    let image: Image
    @Published var isFavorite: Bool
    
    init(name: String, image: Image, isFavorite: Bool) {
        self.name = name
        self.image = image
        self.isFavorite = isFavorite
    }
}
