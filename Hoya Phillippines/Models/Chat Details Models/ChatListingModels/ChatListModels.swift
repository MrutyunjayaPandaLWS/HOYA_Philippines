//
//  ChatListModels.swift
//  Hoya Phillippines
//
//  Created by admin on 21/06/23.
//

import Foundation

struct ChatListModels : Codable {
    let objQueryCenterList : String?
    let objQueryResponseList : String?
    let objQueryResponseJsonList : [ObjQueryResponseJsonList]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case objQueryCenterList = "objQueryCenterList"
        case objQueryResponseList = "objQueryResponseList"
        case objQueryResponseJsonList = "objQueryResponseJsonList"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        objQueryCenterList = try values.decodeIfPresent(String.self, forKey: .objQueryCenterList)
        objQueryResponseList = try values.decodeIfPresent(String.self, forKey: .objQueryResponseList)
        objQueryResponseJsonList = try values.decodeIfPresent([ObjQueryResponseJsonList].self, forKey: .objQueryResponseJsonList)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
