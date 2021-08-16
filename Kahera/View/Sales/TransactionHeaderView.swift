//
//  TransactionHeaderView.swift
//  TransactionHeaderView
//
//  Created by Vincio on 8/16/21.
//

import SwiftUI

struct TransactionHeaderView: View {
    var transaction: Sales
    
    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        return dateFormatter
    }

    
    var body: some View {

        VStack {
            Text(formatter.string(from: transaction.wrappedDate))
                .titleFont()
            Text(transaction.wrappedCustomerName)
                .detailFont()
        }
        .offset(y: 100)
        .ignoresSafeArea()
       
           

    }
}

struct TransactionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHeaderView(transaction: Sales())
    }
}
