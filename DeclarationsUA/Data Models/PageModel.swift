//
//  PageModel.swift
//  DeclarationsUA
//
//  Created by Alexander on 04.12.2020.
//

import Foundation

struct PageModel: Codable { // "page"

    let currentPage: Int
    let batchSize: Int
    let totalItems: String
}
