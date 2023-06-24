//
//  termsAndConditionModels.swift
//  Hoya Phillippines
//
//  Created by admin on 19/06/23.
//

import Foundation
struct termsAndConditionModels : Codable {
    let lstTermsAndCondition : [LstTermsAndCondition]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case lstTermsAndCondition = "lstTermsAndCondition"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstTermsAndCondition = try values.decodeIfPresent([LstTermsAndCondition].self, forKey: .lstTermsAndCondition)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}

