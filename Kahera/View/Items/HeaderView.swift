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
    @State private var showAddItem = false
    var body: some View {
            ZStack {
                if !edit {
                    Text(title)
                        .titleFont()
                        .onTapGesture {
                            self.edit = true
                        }
                    HStack {
                        Spacer()
                        Button(action:{self.showAddItem = true}) {
                            Image(systemName: "plus")
                                .font(Font.system(size: 24, weight: .regular))

                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 15)

                        Button(action: { }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(Font.system(size: 24, weight: .regular))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 15)
                    }

                } else {
                    HStack {
                        TextField(title, text: $title, onCommit: {self.edit = false})
                        Button("Done"){
                            self.edit = false
                        }
                    }
                    .padding(.leading, 70)

                }
            }

            .frame(height: 60)
            .offset(x: -1)
            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .padding()
            .sheet(isPresented: $showAddItem, content: {
                AddItemView(showAddItem: $showAddItem)
            })


    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}