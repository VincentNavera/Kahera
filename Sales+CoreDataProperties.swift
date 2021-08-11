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
    @NSManaged public var total: Double
    @NSManaged public var taxableSales: String?
    @NSManaged public var tax: String?
    @NSManaged public var cash: String?
    @NSManaged public var change: String?
    @NSManaged public var discount: String?
    @NSManaged public var taxExempt: String?
    @NSManaged public var customerName: String?
    @NSManaged public var taxExemptSales: String?
    @NSManaged public var items: CheckOutItems?

}

extension Sales : Identifiable {

}
