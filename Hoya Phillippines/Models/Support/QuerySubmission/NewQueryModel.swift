

import Foundation
struct NewQueryModel : Codable {
	let objCustomerQueryFileUploadDetailsList : String?
	let objCustomerQueryFileStatus : String?
	let objCustomerAllQueryList : String?
	let objCustomerAllQueryJsonList : String?
	let lstcustomerqrydetails : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case objCustomerQueryFileUploadDetailsList = "objCustomerQueryFileUploadDetailsList"
		case objCustomerQueryFileStatus = "objCustomerQueryFileStatus"
		case objCustomerAllQueryList = "objCustomerAllQueryList"
		case objCustomerAllQueryJsonList = "objCustomerAllQueryJsonList"
		case lstcustomerqrydetails = "lstcustomerqrydetails"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		objCustomerQueryFileUploadDetailsList = try values.decodeIfPresent(String.self, forKey: .objCustomerQueryFileUploadDetailsList)
		objCustomerQueryFileStatus = try values.decodeIfPresent(String.self, forKey: .objCustomerQueryFileStatus)
		objCustomerAllQueryList = try values.decodeIfPresent(String.self, forKey: .objCustomerAllQueryList)
		objCustomerAllQueryJsonList = try values.decodeIfPresent(String.self, forKey: .objCustomerAllQueryJsonList)
		lstcustomerqrydetails = try values.decodeIfPresent(String.self, forKey: .lstcustomerqrydetails)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
