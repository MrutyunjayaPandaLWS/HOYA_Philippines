//
//  InvoiceNumberValidationModels.swift
//  Hoya Phillippines
//
//  Created by admin on 20/06/23.
//

import Foundation
struct InvoiceNumberValidationModels : Codable {
    let lstAttributesDetails : [InvoiceNumeberValidation]?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case lstAttributesDetails = "lstAttributesDetails"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstAttributesDetails = try values.decodeIfPresent([InvoiceNumeberValidation].self, forKey: .lstAttributesDetails)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
