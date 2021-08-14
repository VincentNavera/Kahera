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
    @State var selection = ""
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("2021")
                    ForEach(months, id: \.self) { month in
                        Section(header: Text(month)) {
                            ForEach(sales, id: \.date) { transaction in

                                if formatter.string(from: transaction.wrappedDate).contains(month) {
                                    NavigationLink(formatter.string(from: transaction.wrappedDate), destination: TransactionView(transaction: transaction))
                                        .onAppear{print("CHECKOUT\(transaction.itemsArray)")}

                                }




                            }

                        }

                    }
                .listStyle(GroupedListStyle())

                }
            }

        }
    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
