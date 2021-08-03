//
//  ContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ItemsView()
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
           .previewLayout(.fixed(width: 1024, height: 768))
           // iPad Mini landscape size
    }
}
