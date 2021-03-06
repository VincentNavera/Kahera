//
//  ContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showCart = false
    @State private var showSideBarIcon = true
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    var body: some View {
        ZStack {
            HStack(spacing: -5) {
                if showCart {
                    CartView(cart: cart)
                        .transition(.move(edge: .leading))
                }

                TabItemsView(cart: cart, showCart: $showCart, showSideBarIcon: $showSideBarIcon)
                    .animation(.default)
                    
            }
            HStack {
                VStack {
                    if showSideBarIcon {
                    Button(action: sideBarIsPressed, label: {
                        Image(systemName: "sidebar.left")
                            .font(Font.system(size: 24, weight: .regular))
                          })
                    }


                    Spacer()
                }
                Spacer()
            }
            .padding(.init(top: 43.4, leading: 20, bottom: 0, trailing: 0))
        }
        .foregroundColor(Color(hex: "414243"))
        .preferredColorScheme(.light)

        .ignoresSafeArea()
        .onAppear{self.showCart = true}
    }
    func sideBarIsPressed() {
        withAnimation(.spring()){
            showCart.toggle()}
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView(cart: CartItems())
                .previewInterfaceOrientation(.landscapeRight)
        } else {
            // Fallback on earlier versions
        }
           // iPad Mini landscape size
    }
}
