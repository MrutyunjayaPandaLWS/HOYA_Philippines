//
//  LstCustomerIdentityInfo.swift
//  Hoya Phillippines
//
//  Created by admin on 23/06/23.
//

import Foundation
struct LstCustomerIdentityInfo : Codable {
    let identityID : Int?
    let identityType : String?
    let identityNo : String?
    let identityDocument : String?
    let isNewIdentity : Bool?
    let identityTypeID : Int?
    let identityName : String?

    enum CodingKeys: String, CodingKey {

        case identityID = "identityID"
        case identityType = "identityType"
        case identityNo = "identityNo"
        case identityDocument = "identityDocument"
        case isNewIdentity = "isNewIdentity"
        case identityTypeID = "identityTypeID"
        case identityName = "identityName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identityID = try values.decodeIfPresent(Int.self, forKey: .identityID)
        identityType = try values.decodeIfPresent(String.self, forKey: .identityType)
        identityNo = try values.decodeIfPresent(String.self, forKey: .identityNo)
        identityDocument = try values.decodeIfPresent(String.self, forKey: .identityDocument)
        isNewIdentity = try values.decodeIfPresent(Bool.self, forKey: .isNewIdentity)
        identityTypeID = try values.decodeIfPresent(Int.self, forKey: .identityTypeID)
        identityName = try values.decodeIfPresent(String.self, forKey: .identityName)
    }

}
