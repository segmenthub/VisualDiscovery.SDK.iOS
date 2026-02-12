//
//  VisualDiscoverySDK.swift
//
//  Created by Mehmet Kılınçkaya on 30.01.2026.
//

import Foundation
struct VDDetectItem : Codable {
    
	let label : String?
	let confidence : Double?
	let image_url : String?
	let search_url : String?
    let box : VDBoxModel?

	enum CodingKeys: String, CodingKey {

		case label = "label"
		case confidence = "confidence"
		case image_url = "image_url"
		case search_url = "search_url"
        case box = "box"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		confidence = try values.decodeIfPresent(Double.self, forKey: .confidence)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		search_url = try values.decodeIfPresent(String.self, forKey: .search_url)
        box = try values.decodeIfPresent(VDBoxModel.self, forKey: .box)
	}

}
