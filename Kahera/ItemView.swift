//
//  ItemView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemView: View {

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(minWidth: 200)
                .frame(height: 110)
                .cornerRadius(10)

            VStack(spacing: 0) {
                Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 188, height: 100)
                VStack(spacing: -8) {
                    Text("Item")
                        .titleFont()
                    Text("₱99.00")
                        .detailFont()
                        .foregroundColor(.black)
                        .padding(.top, 5.0)

                }
            }
            .frame(height: 100)
            .padding(.bottom, 25)
            .padding(.horizontal, 5)
            .background(Color.clear)
        }

    }
}
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
            .previewLayout(.sizeThatFits)


    }
}
