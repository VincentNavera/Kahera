//
//  CartItemModel.swift
//  Kahera
//
//  Created by Vincio on 8/7/21.
//

import Foundation

struct CartItemModel: Identifiable {


    let id = UUID()
    let name: String
    let price: Double
    let quantity: String

}
