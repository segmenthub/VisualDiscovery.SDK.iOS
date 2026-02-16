//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import Foundation
nonisolated public struct VDDetectItem : Codable, Sendable {
    
    public let label : String?
    public let confidence : Double?
    public let image_url : String?
    public let search_url : String?
    public let box : VDBoxModel?

	enum CodingKeys: String, CodingKey {

		case label = "label"
		case confidence = "confidence"
		case image_url = "image_url"
		case search_url = "search_url"
        case box = "box"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		confidence = try values.decodeIfPresent(Double.self, forKey: .confidence)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		search_url = try values.decodeIfPresent(String.self, forKey: .search_url)
        box = try values.decodeIfPresent(VDBoxModel.self, forKey: .box)
	}

}
