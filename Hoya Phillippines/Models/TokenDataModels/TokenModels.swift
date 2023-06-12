//
//  TokenModels.swift
//  Hoya Phillippines
//
//  Created by syed on 13/03/23.
//

import Foundation

import Foundation
struct TokenModels : Codable {
    let access_token : String?
    let token_type : String?
    let expires_in : Int?
    let userName : String?
//    let .issued : String?
//    let .expires : String?

    enum CodingKeys: String, CodingKey {

        case access_token = "access_token"
        case token_type = "token_type"
        case expires_in = "expires_in"
        case userName = "userName"
//        case .issued = ".issued"
//        case .expires = ".expires"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        token_type = try values.decodeIfPresent(String.self, forKey: .token_type)
        expires_in = try values.decodeIfPresent(Int.self, forKey: .expires_in)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
//        .issued = try values.decodeIfPresent(String.self, forKey: ..issued)
//        .expires = try values.decodeIfPresent(String.self, forKey: ..expires)
    }

}
