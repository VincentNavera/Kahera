//
//  ContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showCart = false
    var body: some View {
        ZStack {
            HStack {
                if showCart {
                    CartView()
                }
                ItemsView()
            }
            HStack {
                VStack {
                    Image(systemName: "sidebar.left")
                        .font(Font.system(size: 24, weight: .thin))
                        .onTapGesture {
                            withAnimation(.spring()){
                                showCart.toggle()}
                        }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
           .previewLayout(.fixed(width: 1024, height: 768))
           // iPad Mini landscape size
    }
}
