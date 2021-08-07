//
//  ContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showCart = false
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    var body: some View {
        ZStack {
            HStack(spacing: -5) {
                if showCart {
                    CartView(cart: cart)
                        .transition(.move(edge: .leading))
                }

                ItemsView(cart: cart)
                    .animation(.easeIn(duration: 0.3))
            }
            HStack {
                VStack {
                    Image(systemName: "sidebar.left")
                        .font(Font.system(size: 24, weight: .regular))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .onTapGesture {
                            withAnimation(.spring()){
                                showCart.toggle()}
                        }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding()
        }
        .preferredColorScheme(.light)

        .ignoresSafeArea()
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(cart: CartItems())
           .previewLayout(.fixed(width: 1024, height: 768))
           // iPad Mini landscape size
    }
}
