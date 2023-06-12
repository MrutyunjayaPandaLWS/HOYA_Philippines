

import Foundation
struct ObjActivityDetailsJsonList : Codable {
	let message : String?
	let name : String?
	let activityDate : String?
	let jActivityDate : String?
	let type : String?
	let email : String?
	let mobile : String?
	let token : String?
	let actorId : Int?
	let isActive : Bool?
	let actorRole : String?
	let actionType : Int?

	enum CodingKeys: String, CodingKey {

		case message = "message"
		case name = "name"
		case activityDate = "activityDate"
		case jActivityDate = "jActivityDate"
		case type = "type"
		case email = "email"
		case mobile = "mobile"
		case token = "token"
		case actorId = "actorId"
		case isActive = "isActive"
		case actorRole = "actorRole"
		case actionType = "actionType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		activityDate = try values.decodeIfPresent(String.self, forKey: .activityDate)
		jActivityDate = try values.decodeIfPresent(String.self, forKey: .jActivityDate)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
	}

}
