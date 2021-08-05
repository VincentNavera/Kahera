//
//  CartHeaderView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("CART (0)")
                .titleFont()
            Spacer()
            Image(systemName: "trash")
                .font(Font.system(size: 24, weight: .thin))
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .frame(height: 60)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .offset(x: -1)

    }
}

struct CartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CartHeaderView()
    }
}
