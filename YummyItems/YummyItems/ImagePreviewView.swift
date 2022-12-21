//
//  ImagePreviewView.swift
//  YummyItems
//
//
//  Created by macOS Catalina on 19.12.2022.
//

import SwiftUI

struct ImagePreviewView: View {
    
    var image: UIImage
    @Binding var showImagePreview: Bool
    @State private var scaleFactor: CGFloat = 1.0
    let customerName: String
    
    var body: some View {
        NavigationView {
            Image(uiImage: image)
                .resizable()
                .scaleEffect(scaleFactor)
                .frame(width: 300, height: 300)
                .gesture(MagnificationGesture().onChanged{ (value) in
                    self.scaleFactor = value.magnitude
                }).gesture(TapGesture(count: 2).onEnded({ (_) in
                    self.scaleFactor = 1.0
                })).animation(.spring())
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle(Text(customerName + "'s Pic"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.showImagePreview.toggle()
                }) {
                    Text("Cancel")
                })
        }
    }
}
