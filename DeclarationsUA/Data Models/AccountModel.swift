//
//  AccountModel.swift
//  DeclarationsUA
//
//  Created by Alexander on 04.12.2020.
//

import Foundation

struct AccountModel: Codable { // "items"
    
    let id: String
    let firstname: String
    let lastname: String
    let placeOfWork: String?
    let position: String?
    let linkPDF: String?
}
