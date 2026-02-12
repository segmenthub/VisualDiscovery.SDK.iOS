//
//  VisualDiscoverySDK.swift
//
//  Created by Mehmet Kılınçkaya on 30.01.2026.
//

import Foundation
struct VDProductItem : Codable {
	let id : String?
	let name : String?
	let url : String?
	let click_event_url : String?
	let image_url : String?
	let price : Double?
	let old_price : Double?
	let similarity : Double?
	let match_type : String?
	let matched_label : String?
	let brand : String?
	let category : String?
	let currency : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case url = "url"
		case click_event_url = "click_event_url"
		case image_url = "image_url"
		case price = "price"
		case old_price = "old_price"
		case similarity = "similarity"
		case match_type = "match_type"
		case matched_label = "matched_label"
		case brand = "brand"
		case category = "category"
		case currency = "currency"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		click_event_url = try values.decodeIfPresent(String.self, forKey: .click_event_url)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		old_price = try values.decodeIfPresent(Double.self, forKey: .old_price)
		similarity = try values.decodeIfPresent(Double.self, forKey: .similarity)
		match_type = try values.decodeIfPresent(String.self, forKey: .match_type)
		matched_label = try values.decodeIfPresent(String.self, forKey: .matched_label)
		brand = try values.decodeIfPresent(String.self, forKey: .brand)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
	}

}
