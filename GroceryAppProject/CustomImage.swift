//
//  CustomImage.swift
//  GroceryAppProject
//
//  Created by Parisa on 2025-03-02.
//


import SwiftUI

struct CustomImage: View {
    var imageName: String
    
    var body: some View {
        // If an asset exists with this name, use it; otherwise, use system image.
        if UIImage(named: imageName) != nil {
            Image(imageName)
                .resizable()
        } else {
            Image(systemName: imageName)
                .resizable()
        }
    }
}
