//
//  SplashScreenView.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali KABA on 2025-03-02.

//


// This file has been moved to Launcher Screen! IT HAS NOT BEEN USED anymore.

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                NavigationView {
                    AuthView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
                VStack {
                    Image("logonobg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                        .padding(.top, 20)

                    Text("Designed by \n\nHamed Haghani,\nMehmet Ali KABA,\nParisa Mohammadkarimi")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
