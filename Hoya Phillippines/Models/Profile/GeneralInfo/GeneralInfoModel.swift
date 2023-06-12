

import Foundation
struct GeneralInfoModel : Codable {
	let lstCustomerJson : [LstCustomerJson]?
	let lstVehicleJson : [String]?
	let lstCustomerOfficalInfoJson : [LstCustomerOfficalInfoJson]?
	let lstCustomerIdentityInfo : String?
	let customerBasicInfoList : String?
	let objCustomer : String?
	let objCustomerDetails : String?
	let objCustomerOfficalInfo : String?
	let hierarchyMapDetails : String?
	let customerFamilyList : String?
	let customerPreferenceList : String?
	let mappedProductList : String?
	let subscriptionDetails : String?
	let lstWorkSiteInfoDetails : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case lstCustomerJson = "lstCustomerJson"
		case lstVehicleJson = "lstVehicleJson"
		case lstCustomerOfficalInfoJson = "lstCustomerOfficalInfoJson"
		case lstCustomerIdentityInfo = "lstCustomerIdentityInfo"
		case customerBasicInfoList = "customerBasicInfoList"
		case objCustomer = "objCustomer"
		case objCustomerDetails = "objCustomerDetails"
		case objCustomerOfficalInfo = "objCustomerOfficalInfo"
		case hierarchyMapDetails = "hierarchyMapDetails"
		case customerFamilyList = "customerFamilyList"
		case customerPreferenceList = "customerPreferenceList"
		case mappedProductList = "mappedProductList"
		case subscriptionDetails = "subscriptionDetails"
		case lstWorkSiteInfoDetails = "lstWorkSiteInfoDetails"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lstCustomerJson = try values.decodeIfPresent([LstCustomerJson].self, forKey: .lstCustomerJson)
		lstVehicleJson = try values.decodeIfPresent([String].self, forKey: .lstVehicleJson)
		lstCustomerOfficalInfoJson = try values.decodeIfPresent([LstCustomerOfficalInfoJson].self, forKey: .lstCustomerOfficalInfoJson)
		lstCustomerIdentityInfo = try values.decodeIfPresent(String.self, forKey: .lstCustomerIdentityInfo)
		customerBasicInfoList = try values.decodeIfPresent(String.self, forKey: .customerBasicInfoList)
		objCustomer = try values.decodeIfPresent(String.self, forKey: .objCustomer)
		objCustomerDetails = try values.decodeIfPresent(String.self, forKey: .objCustomerDetails)
		objCustomerOfficalInfo = try values.decodeIfPresent(String.self, forKey: .objCustomerOfficalInfo)
		hierarchyMapDetails = try values.decodeIfPresent(String.self, forKey: .hierarchyMapDetails)
		customerFamilyList = try values.decodeIfPresent(String.self, forKey: .customerFamilyList)
		customerPreferenceList = try values.decodeIfPresent(String.self, forKey: .customerPreferenceList)
		mappedProductList = try values.decodeIfPresent(String.self, forKey: .mappedProductList)
		subscriptionDetails = try values.decodeIfPresent(String.self, forKey: .subscriptionDetails)
		lstWorkSiteInfoDetails = try values.decodeIfPresent(String.self, forKey: .lstWorkSiteInfoDetails)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
