//
//  ItemsContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsContentView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 10)], spacing: 34) {
                ForEach(0..<20) { _ in
                    ItemView()
                }
            }.padding(.top, 40)
            .padding(.horizontal, 10)
        }
    }
}

struct ItemsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsContentView()
    }
}
