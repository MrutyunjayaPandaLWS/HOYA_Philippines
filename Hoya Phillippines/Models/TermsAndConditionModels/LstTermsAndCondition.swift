//
//  LstTermsAndCondition.swift
//  Hoya Phillippines
//
//  Created by admin on 19/06/23.
//

import Foundation

struct LstTermsAndCondition : Codable {
    let termsAndConditionsId : Int?
    let tcName : String?
    let html : String?
    let color : String?
    let statusName : String?
    let fileName : String?
    let createDate : String?
    let segmentId : Int?
    let segmentType : String?
    let segmentName : String?
    let wefDate : String?
    let languageId : Int?
    let language : String?
    let token : String?
    let actorId : Int?
    let isActive : Bool?
    let actorRole : String?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case termsAndConditionsId = "termsAndConditionsId"
        case tcName = "tcName"
        case html = "html"
        case color = "color"
        case statusName = "statusName"
        case fileName = "fileName"
        case createDate = "createDate"
        case segmentId = "segmentId"
        case segmentType = "segmentType"
        case segmentName = "segmentName"
        case wefDate = "wefDate"
        case languageId = "languageId"
        case language = "language"
        case token = "token"
        case actorId = "actorId"
        case isActive = "isActive"
        case actorRole = "actorRole"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        termsAndConditionsId = try values.decodeIfPresent(Int.self, forKey: .termsAndConditionsId)
        tcName = try values.decodeIfPresent(String.self, forKey: .tcName)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        segmentId = try values.decodeIfPresent(Int.self, forKey: .segmentId)
        segmentType = try values.decodeIfPresent(String.self, forKey: .segmentType)
        segmentName = try values.decodeIfPresent(String.self, forKey: .segmentName)
        wefDate = try values.decodeIfPresent(String.self, forKey: .wefDate)
        languageId = try values.decodeIfPresent(Int.self, forKey: .languageId)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
