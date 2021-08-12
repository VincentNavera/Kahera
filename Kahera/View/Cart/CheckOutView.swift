//
//  CheckOutView.swift
//  CheckOutView
//
//  Created by Vincio on 8/12/21.
//

import SwiftUI

struct CheckOutView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 70)
                    .foregroundColor(Color(hex: "414243"))

                HStack {
                    Text("Check Out".uppercased())
                        .largeTitleFont()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .foregroundColor(Color.white)

            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .frame(height: 93)
        .scaleEffect(animationAmount)
        .animation(.default)

        .onTapGesture {
            self.animationAmount += 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.animationAmount = 1

            }

        }
//sada





    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}
