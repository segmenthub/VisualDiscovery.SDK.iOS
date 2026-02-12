//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import Foundation

public struct VDProductItem : Codable {
    public let id: String?
    public let name: String?
    public let url: String?
    public let click_event_url: String?
    public let image_url: String?
    public let price: Double?
    public let old_price: Double?
    public let similarity: Double?
    public let match_type: String?
    public let matched_label: String?
    public let brand: String?
    public let category: String?
    public let currency: String?
    
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
    
    public init(from decoder: Decoder) throws {
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
