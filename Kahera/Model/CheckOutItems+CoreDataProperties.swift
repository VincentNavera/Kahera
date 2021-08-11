//
//  CheckOutItems+CoreDataProperties.swift
//  CheckOutItems
//
//  Created by Vincio on 8/11/21.
//
//

import Foundation
import CoreData


extension CheckOutItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckOutItems> {
        return NSFetchRequest<CheckOutItems>(entityName: "CheckOutItems")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var price: Double
    @NSManaged public var barcode: String?
    @NSManaged public var transaction: NSSet?

    public var wrappedName: String {
        name ?? "No Item Name"
    }
    public var wrappedBarcode: String {
        barcode ?? "000000000000"
    }

    public var transactionArray: [Sales] {
        let set = transaction as? Set<Sales> ?? []
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }

}

// MARK: Generated accessors for transaction
extension CheckOutItems {

    @objc(addTransactionObject:)
    @NSManaged public func addToTransaction(_ value: Sales)

    @objc(removeTransactionObject:)
    @NSManaged public func removeFromTransaction(_ value: Sales)

    @objc(addTransaction:)
    @NSManaged public func addToTransaction(_ values: NSSet)

    @objc(removeTransaction:)
    @NSManaged public func removeFromTransaction(_ values: NSSet)

}

extension CheckOutItems : Identifiable {

}
