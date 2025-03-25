//
//  Meeting.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

struct Meeting: Decodable {
    let id: String
    let name: String
    let categoryID: String
    let country: String?
    enum CodingKeys: String, CodingKey {
            case id, name, country
            case categoryID = "category_id"
        }
}
