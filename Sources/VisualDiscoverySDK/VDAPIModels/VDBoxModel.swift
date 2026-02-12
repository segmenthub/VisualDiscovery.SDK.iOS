//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import Foundation
nonisolated public struct VDBoxModel : Codable {
	let x1 : Int?
	let y1 : Int?
	let x2 : Int?
	let y2 : Int?

	enum CodingKeys: String, CodingKey {

		case x1 = "x1"
		case y1 = "y1"
		case x2 = "x2"
		case y2 = "y2"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		x1 = try values.decodeIfPresent(Int.self, forKey: .x1)
		y1 = try values.decodeIfPresent(Int.self, forKey: .y1)
		x2 = try values.decodeIfPresent(Int.self, forKey: .x2)
		y2 = try values.decodeIfPresent(Int.self, forKey: .y2)
	}

}
