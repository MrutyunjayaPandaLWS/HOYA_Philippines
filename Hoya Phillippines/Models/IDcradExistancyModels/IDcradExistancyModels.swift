//
//  IDcradExistancyModels.swift
//  Hoya Phillippines
//
//  Created by admin on 19/06/23.
//

import Foundation
struct IDcradExistancyModels : Codable {
    let lstAttributesDetails : [idCardExistancy1]?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case lstAttributesDetails = "lstAttributesDetails"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstAttributesDetails = try values.decodeIfPresent([idCardExistancy1].self, forKey: .lstAttributesDetails)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
