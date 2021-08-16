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
    @NSManaged public var taxableSales: Double
    @NSManaged public var tax: Double
    @NSManaged public var cash: Double
    @NSManaged public var change: Double
    @NSManaged public var discount: Double
    @NSManaged public var taxExempt: Double
    @NSManaged public var customerName: String?
    @NSManaged public var taxExemptSales: Double
    @NSManaged public var deliveryFee: Double
    @NSManaged public var items: NSSet?

    public var wrappedDate: Date {
        date ?? Date()
    }

    public var wrappedFormattedDate: String {
        formattedDate ?? "No Date (Like you)"
    }


    public var wrappedCustomerName: String {
        customerName ?? "No name was provided"
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
