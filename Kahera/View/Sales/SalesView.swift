//
//  SalesView.swift
//  SalesView
//
//  Created by Vincio on 8/13/21.
//

import SwiftUI

struct SalesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Sales.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Sales.date, ascending: true),]) var sales: FetchedResults<Sales>
    @State private var year: Int = 0
    let currentYear = Calendar.current.component(.year, from: Date())
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
    @Binding var showCart: Bool

    var body: some View {
        NavigationView {
            VStack {
                List {

                    Picker(String(year), selection: $year) {
                            ForEach(2021 ..< currentYear + 1) { item in
                                Text(String(item))
                            }
                    }
                    .colorInvert()
                    .colorMultiply(Color(hex: "8fbd71"))
                    .pickerStyle(MenuPickerStyle())

                    ForEach(months, id: \.self) { month in
                        Section(header: Text(month)) {
                            ForEach(sales, id: \.date) { transaction in

                                if formatter.string(from: transaction.wrappedDate).contains(month) && Calendar.current.component(.year, from: transaction.wrappedDate) == currentYear { //to be fixed

                                    NavigationLink(formatter.string(from: transaction.wrappedDate), destination: TransactionView(transaction: transaction))
                                        .onAppear{print(transaction.wrappedDate)}

                                }




                            }

                        }

                    }
                .listStyle(GroupedListStyle())

                }
            }
            .navigationBarTitle("Records")

        }
    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView(showCart: .constant(false))
    }
}
