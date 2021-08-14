//
//  Sales+CoreDataProperties.swift
//  Sales
//
//  Created by Vincio on 8/11/21.
//
//

import Foundation
import CoreData


extension Sales {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sales> {
        return NSFetchRequest<Sales>(entityName: "Sales")
    }

    @NSManaged public var date: Date?
    @NSManaged public var formattedDate: String?
    @NSManaged public var total: Double
    @NSManaged public var taxableSales: String?
    @NSManaged public var tax: String?
    @NSManaged public var cash: String?
    @NSManaged public var change: String?
    @NSManaged public var discount: String?
    @NSManaged public var taxExempt: String?
    @NSManaged public var customerName: String?
    @NSManaged public var taxExemptSales: String?
    @NSManaged public var deliveryFee: String?
    @NSManaged public var items: NSSet?

    public var wrappedDate: Date {
        date ?? Date()
    }
    public var wrappedFormattedDate: String {
        formattedDate ?? "No Date (Like you)"
    }

    public var wrappedtaxableSales: String {
        taxableSales ?? "0.00"
    }

    public var wrappedTax: String {
        tax ?? "0.00"
    }

    public var wrappedCash: String {
        cash ?? "0.00"
    }
    public var wrappedChange: String {
        change ?? "0.00"
    }
    public var wrappedDiscount: String {
        discount ?? "0.00"
    }

    public var wrappedTaxExempt: String {
        taxExempt ?? "0.00"
    }
    public var wrappedTaxExemptSales: String {
        taxExemptSales ?? "0.00"
    }
    public var wrappedCustomerName: String {
        customerName ?? "No name was provided"
    }
    public var wrappedDeliveryFee: String {
        deliveryFee ?? "0.00"
    }

    public var itemsArray: [CheckOutItems] {
        let set = items as? Set<CheckOutItems> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    

}

extension Sales : Identifiable {

}
