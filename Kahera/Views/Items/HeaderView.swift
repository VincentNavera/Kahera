//
//  HeaderView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct HeaderView: View {
    @State private var edit = false
    @State private var title = "STORE NAME"
    var body: some View {
        ZStack {
                HStack {
                    if !edit {
                        Text(title)
                            .titleFont()
                            .onTapGesture {
                                self.edit = true
                            }

                    } else {
                        HStack {
                            TextField(title, text: $title, onCommit: {self.edit = false})
                            Button("Done"){
                                self.edit = false
                            }
                        }

                    }
                }

                .frame(height: 60)
                .offset(x: -1)


            HStack {
                Spacer()
                Button(action: { }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(Font.system(size: 24, weight: .thin))
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color.black)
                .padding(.trailing, 15)
            }
        }
        .padding()
    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
