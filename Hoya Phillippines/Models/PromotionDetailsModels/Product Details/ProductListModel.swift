//
//  ProductListModel.swift
//  Hoya Phillippines
//
//  Created by admin on 19/06/23.
//

import Foundation
struct ProductListModel : Codable {
    let lsrProductDetails : [LsrProductDetails]?
    let lstImageSubCat : String?
    let lstColor : String?
    let lstColorSize : String?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case lsrProductDetails = "lsrProductDetails"
        case lstImageSubCat = "lstImageSubCat"
        case lstColor = "lstColor"
        case lstColorSize = "lstColorSize"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lsrProductDetails = try values.decodeIfPresent([LsrProductDetails].self, forKey: .lsrProductDetails)
        lstImageSubCat = try values.decodeIfPresent(String.self, forKey: .lstImageSubCat)
        lstColor = try values.decodeIfPresent(String.self, forKey: .lstColor)
        lstColorSize = try values.decodeIfPresent(String.self, forKey: .lstColorSize)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
