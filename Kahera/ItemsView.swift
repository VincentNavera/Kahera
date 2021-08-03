//
//  ItemsView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsView: View {
    var body: some View {
        VStack {
            HeaderView()
            ItemsContentView()
        }
        .background(Color(#colorLiteral(red: 0.8919270833, green: 0.8919270833, blue: 0.8919270833, alpha: 1)))
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
            
    }
}
