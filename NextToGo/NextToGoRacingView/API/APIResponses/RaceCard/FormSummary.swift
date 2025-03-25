//
//  FormSummary.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import Foundation

struct FormSummary: Decodable {
    let last20Starts: String?
    let riderOrDriver: String?
    let trainerName: String?
    let bestTime: String?
    let handicapWeight: Double?
    let entrantComment: String?
}
