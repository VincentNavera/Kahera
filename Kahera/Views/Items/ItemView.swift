//
//  ItemView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemView: View {

    var itemLabel: String
    var priceLabel: Double

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(Color(.displayP3, red: 1, green: 1, blue: 1, opacity: 1.0))
                .frame(minWidth: 200)
                .frame(height: 110)
                .cornerRadius(24)
                .shadow(color: Color(.displayP3, red: 242/255, green: 242/255, blue: 1, opacity: 1.0), radius: 24)

            VStack(spacing: 0) {
                Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 188, height: 100)
                VStack(spacing: -8) {
                    Text(itemLabel)
                        .titleFont()
                    Text("₱\(Double(priceLabel) , specifier: "%.2f")") //format to two decimal places
                        .detailFont()
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
        ItemView(itemLabel: "Item", priceLabel: 9999.99)
            .previewLayout(.sizeThatFits)


    }
}
