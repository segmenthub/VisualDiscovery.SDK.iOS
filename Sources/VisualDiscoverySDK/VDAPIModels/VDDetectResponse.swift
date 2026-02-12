//
//  VisualDiscoverySDK.swift
//
//  Created by Mehmet Kılınçkaya on 30.01.2026.
//

import Foundation

nonisolated struct VDDetectResponse : Codable, Sendable {
    
	let status : String?
	let request_id : String?
	let detections : [VDDetectItem]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case request_id = "request_id"
		case detections = "detections"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
		detections = try values.decodeIfPresent([VDDetectItem].self, forKey: .detections)
	}

}
