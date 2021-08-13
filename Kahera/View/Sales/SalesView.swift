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
    var body: some View {
        ForEach(sales, id: \.date) { item in
            VStack {
                Text(item.wrappedCustomerName)
            }
        }

    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
