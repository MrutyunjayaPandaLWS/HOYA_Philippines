//
//  ObjQueryResponseJsonList.swift
//  Hoya Phillippines
//
//  Created by admin on 21/06/23.
//

import Foundation

struct ObjQueryResponseJsonList : Codable {
    let repliedBy : String?
    let createdDate : String?
    let jCreatedDate : String?
    let queryResponseInfo : String?
    let queryStatus : String?
    let color : String?
    let userType : String?
    let imageUrl : String?

    enum CodingKeys: String, CodingKey {

        case repliedBy = "repliedBy"
        case createdDate = "createdDate"
        case jCreatedDate = "jCreatedDate"
        case queryResponseInfo = "queryResponseInfo"
        case queryStatus = "queryStatus"
        case color = "color"
        case userType = "userType"
        case imageUrl = "imageUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repliedBy = try values.decodeIfPresent(String.self, forKey: .repliedBy)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
        queryResponseInfo = try values.decodeIfPresent(String.self, forKey: .queryResponseInfo)
        queryStatus = try values.decodeIfPresent(String.self, forKey: .queryStatus)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        userType = try values.decodeIfPresent(String.self, forKey: .userType)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }

}
