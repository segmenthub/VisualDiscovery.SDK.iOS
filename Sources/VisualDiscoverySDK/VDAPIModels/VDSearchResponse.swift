//
//  VisualDiscoverySDK.swift
//
//  Created by Mehmet Kılınçkaya on 30.01.2026.
//

import Foundation

nonisolated struct VDSearchResponse : Codable, Sendable {
    
	let status : String?
	let similar_products : [VDProductItem]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case similar_products = "similar_products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		similar_products = try values.decodeIfPresent([VDProductItem].self, forKey: .similar_products)
	}

}
