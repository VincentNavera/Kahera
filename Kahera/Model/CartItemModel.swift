//
//  CartItemModel.swift
//  Kahera
//
//  Created by Vincio on 8/7/21.
//

import Foundation

struct CartItemModel: Identifiable, Equatable {


    let id = UUID()
    let name: String
    let price: Double
    var quantity: Int
    var discounted: Bool
    let barcode: String
    var image: String
    

}
