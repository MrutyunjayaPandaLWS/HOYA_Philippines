

import Foundation
struct LstCustomerEntityMapping : Codable {
	let customerEntityMappingId : Int?
	let cityId : Int?
	let areaId : Int?
	let entityName : String?
	let cityName : String?
	let areaName : String?
	let retailerName : String?
	let professionId : Int?
	let mobile : String?
	let address : String?
	let professionName : String?
	let sE_Role : String?
	let sE_UserName : String?
	let sE_EmailId : String?
	let sE_MobileNumber : String?
	let seUserId : Int?
	let customerUserName : String?
	let se_FirstName : String?
	let customerFirstName : String?
	let customerAvalialbePointBalance : Int?
	let customerEnrolledDate : String?
	let status : Int?

	enum CodingKeys: String, CodingKey {

		case customerEntityMappingId = "customerEntityMappingId"
		case cityId = "cityId"
		case areaId = "areaId"
		case entityName = "entityName"
		case cityName = "cityName"
		case areaName = "areaName"
		case retailerName = "retailerName"
		case professionId = "professionId"
		case mobile = "mobile"
		case address = "address"
		case professionName = "professionName"
		case sE_Role = "sE_Role"
		case sE_UserName = "sE_UserName"
		case sE_EmailId = "sE_EmailId"
		case sE_MobileNumber = "sE_MobileNumber"
		case seUserId = "seUserId"
		case customerUserName = "customerUserName"
		case se_FirstName = "se_FirstName"
		case customerFirstName = "customerFirstName"
		case customerAvalialbePointBalance = "customerAvalialbePointBalance"
		case customerEnrolledDate = "customerEnrolledDate"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		customerEntityMappingId = try values.decodeIfPresent(Int.self, forKey: .customerEntityMappingId)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
		entityName = try values.decodeIfPresent(String.self, forKey: .entityName)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
		retailerName = try values.decodeIfPresent(String.self, forKey: .retailerName)
		professionId = try values.decodeIfPresent(Int.self, forKey: .professionId)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		professionName = try values.decodeIfPresent(String.self, forKey: .professionName)
		sE_Role = try values.decodeIfPresent(String.self, forKey: .sE_Role)
		sE_UserName = try values.decodeIfPresent(String.self, forKey: .sE_UserName)
		sE_EmailId = try values.decodeIfPresent(String.self, forKey: .sE_EmailId)
		sE_MobileNumber = try values.decodeIfPresent(String.self, forKey: .sE_MobileNumber)
		seUserId = try values.decodeIfPresent(Int.self, forKey: .seUserId)
		customerUserName = try values.decodeIfPresent(String.self, forKey: .customerUserName)
		se_FirstName = try values.decodeIfPresent(String.self, forKey: .se_FirstName)
		customerFirstName = try values.decodeIfPresent(String.self, forKey: .customerFirstName)
		customerAvalialbePointBalance = try values.decodeIfPresent(Int.self, forKey: .customerAvalialbePointBalance)
		customerEnrolledDate = try values.decodeIfPresent(String.self, forKey: .customerEnrolledDate)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
	}

}
