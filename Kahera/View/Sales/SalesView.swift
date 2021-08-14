//
//  SalesView.swift
//  SalesView
//
//  Created by Vincio on 8/13/21.
//

import SwiftUI

struct SalesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Sales.entity(), sortDescriptors: []) var sales: FetchedResults<Sales>
    @State var selection = ""
    var body: some View {
        VStack {
            Text("Records")
                .titleFont()
            
            List {
                Text("YEAR")
                ForEach(0..<5) { transaction in
                    Section(header: Text("Month")) {
                        ForEach(0..<5) { _ in
                            Text("Date")

                        }

                    }

                }
            .listStyle(GroupedListStyle())

            }
        }

    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
