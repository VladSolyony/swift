//
//  TextBox.swift
//  paint
//
//  Created by macOS Catalina on 19.12.2022.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {

    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    // For dragging the view over the screen
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    
    // You can add whatever properties here
    // I'm simply stopping on this
    var isAdded: Bool = false
}
