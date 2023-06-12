

import Foundation

struct MyStaffListModel : Codable {
	let customerBasicInfoList : String?
	let customerFamilyList : String?
	let objCustomer : String?
	let lstCustomer : String?
	let distributorlst : String?
	let lstSchemeConfigureationDetails : String?
	let retailerlst : String?
	let objCustomerDetails : String?
	let customerPreferenceList : String?
	let lstRewardTransDetails : String?
	let lstRewardTransactionBasedonProduct : String?
	let bindYearWiseAttendanceList : String?
	let mappedProductList : String?
	let hierarchyMapDetails : String?
	let mappedCustomersList : String?
	let customerMappingList : String?
	let subscriptionDetails : String?
	let lstCustomerSearchDetails : String?
	let totEarned : String?
	let totRedeem : String?
	let totSalesReturn : String?
	let totPointExpired : String?
	let pointBal : String?
	let lstVehicleDetails : String?
	let audienceOptimizationId : String?
	let customerOptimizationDetailsList : String?
	let objCustomerOfficalInfo : String?
	let lstCustomerOfficalInfo : String?
	let lstCustomerIdentityInfo : String?
	let lstCustomerEntityMapping : [LstCustomerEntityMapping]?
	let hierarchyMapDetailsList : String?
	let lstCustomerPaymentModeDetails : String?
	let lstWorkSiteInfoDetails : String?
	let lstCustomerRemarksHistory : String?
	let succcessReferealCount : Int?
	let pendingReferalCount : Int?
	let expiredReferalCount : Int?
	let totalWithDrawls : Int?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case customerBasicInfoList = "customerBasicInfoList"
		case customerFamilyList = "customerFamilyList"
		case objCustomer = "objCustomer"
		case lstCustomer = "lstCustomer"
		case distributorlst = "distributorlst"
		case lstSchemeConfigureationDetails = "lstSchemeConfigureationDetails"
		case retailerlst = "retailerlst"
		case objCustomerDetails = "objCustomerDetails"
		case customerPreferenceList = "customerPreferenceList"
		case lstRewardTransDetails = "lstRewardTransDetails"
		case lstRewardTransactionBasedonProduct = "lstRewardTransactionBasedonProduct"
		case bindYearWiseAttendanceList = "bindYearWiseAttendanceList"
		case mappedProductList = "mappedProductList"
		case hierarchyMapDetails = "hierarchyMapDetails"
		case mappedCustomersList = "mappedCustomersList"
		case customerMappingList = "customerMappingList"
		case subscriptionDetails = "subscriptionDetails"
		case lstCustomerSearchDetails = "lstCustomerSearchDetails"
		case totEarned = "totEarned"
		case totRedeem = "totRedeem"
		case totSalesReturn = "totSalesReturn"
		case totPointExpired = "totPointExpired"
		case pointBal = "pointBal"
		case lstVehicleDetails = "lstVehicleDetails"
		case audienceOptimizationId = "audienceOptimizationId"
		case customerOptimizationDetailsList = "customerOptimizationDetailsList"
		case objCustomerOfficalInfo = "objCustomerOfficalInfo"
		case lstCustomerOfficalInfo = "lstCustomerOfficalInfo"
		case lstCustomerIdentityInfo = "lstCustomerIdentityInfo"
		case lstCustomerEntityMapping = "lstCustomerEntityMapping"
		case hierarchyMapDetailsList = "hierarchyMapDetailsList"
		case lstCustomerPaymentModeDetails = "lstCustomerPaymentModeDetails"
		case lstWorkSiteInfoDetails = "lstWorkSiteInfoDetails"
		case lstCustomerRemarksHistory = "lstCustomerRemarksHistory"
		case succcessReferealCount = "succcessReferealCount"
		case pendingReferalCount = "pendingReferalCount"
		case expiredReferalCount = "expiredReferalCount"
		case totalWithDrawls = "totalWithDrawls"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		customerBasicInfoList = try values.decodeIfPresent(String.self, forKey: .customerBasicInfoList)
		customerFamilyList = try values.decodeIfPresent(String.self, forKey: .customerFamilyList)
		objCustomer = try values.decodeIfPresent(String.self, forKey: .objCustomer)
		lstCustomer = try values.decodeIfPresent(String.self, forKey: .lstCustomer)
		distributorlst = try values.decodeIfPresent(String.self, forKey: .distributorlst)
		lstSchemeConfigureationDetails = try values.decodeIfPresent(String.self, forKey: .lstSchemeConfigureationDetails)
		retailerlst = try values.decodeIfPresent(String.self, forKey: .retailerlst)
		objCustomerDetails = try values.decodeIfPresent(String.self, forKey: .objCustomerDetails)
		customerPreferenceList = try values.decodeIfPresent(String.self, forKey: .customerPreferenceList)
		lstRewardTransDetails = try values.decodeIfPresent(String.self, forKey: .lstRewardTransDetails)
		lstRewardTransactionBasedonProduct = try values.decodeIfPresent(String.self, forKey: .lstRewardTransactionBasedonProduct)
		bindYearWiseAttendanceList = try values.decodeIfPresent(String.self, forKey: .bindYearWiseAttendanceList)
		mappedProductList = try values.decodeIfPresent(String.self, forKey: .mappedProductList)
		hierarchyMapDetails = try values.decodeIfPresent(String.self, forKey: .hierarchyMapDetails)
		mappedCustomersList = try values.decodeIfPresent(String.self, forKey: .mappedCustomersList)
		customerMappingList = try values.decodeIfPresent(String.self, forKey: .customerMappingList)
		subscriptionDetails = try values.decodeIfPresent(String.self, forKey: .subscriptionDetails)
		lstCustomerSearchDetails = try values.decodeIfPresent(String.self, forKey: .lstCustomerSearchDetails)
		totEarned = try values.decodeIfPresent(String.self, forKey: .totEarned)
		totRedeem = try values.decodeIfPresent(String.self, forKey: .totRedeem)
		totSalesReturn = try values.decodeIfPresent(String.self, forKey: .totSalesReturn)
		totPointExpired = try values.decodeIfPresent(String.self, forKey: .totPointExpired)
		pointBal = try values.decodeIfPresent(String.self, forKey: .pointBal)
		lstVehicleDetails = try values.decodeIfPresent(String.self, forKey: .lstVehicleDetails)
		audienceOptimizationId = try values.decodeIfPresent(String.self, forKey: .audienceOptimizationId)
		customerOptimizationDetailsList = try values.decodeIfPresent(String.self, forKey: .customerOptimizationDetailsList)
		objCustomerOfficalInfo = try values.decodeIfPresent(String.self, forKey: .objCustomerOfficalInfo)
		lstCustomerOfficalInfo = try values.decodeIfPresent(String.self, forKey: .lstCustomerOfficalInfo)
		lstCustomerIdentityInfo = try values.decodeIfPresent(String.self, forKey: .lstCustomerIdentityInfo)
		lstCustomerEntityMapping = try values.decodeIfPresent([LstCustomerEntityMapping].self, forKey: .lstCustomerEntityMapping)
		hierarchyMapDetailsList = try values.decodeIfPresent(String.self, forKey: .hierarchyMapDetailsList)
		lstCustomerPaymentModeDetails = try values.decodeIfPresent(String.self, forKey: .lstCustomerPaymentModeDetails)
		lstWorkSiteInfoDetails = try values.decodeIfPresent(String.self, forKey: .lstWorkSiteInfoDetails)
		lstCustomerRemarksHistory = try values.decodeIfPresent(String.self, forKey: .lstCustomerRemarksHistory)
		succcessReferealCount = try values.decodeIfPresent(Int.self, forKey: .succcessReferealCount)
		pendingReferalCount = try values.decodeIfPresent(Int.self, forKey: .pendingReferalCount)
		expiredReferalCount = try values.decodeIfPresent(Int.self, forKey: .expiredReferalCount)
		totalWithDrawls = try values.decodeIfPresent(Int.self, forKey: .totalWithDrawls)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
