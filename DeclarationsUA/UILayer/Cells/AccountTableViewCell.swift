//
//  AccountTableViewCell.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var placeOfWorkLabel: UILabel!
    @IBOutlet weak private var pdfIcon: UIImageView!
    
    // идентификатор ячейки и xib-файла по имени экземпляра класса
    static var identifier: String {
        return String(describing: self)
    }
    
    func setup(with account: AccountModel) {
        
        nameLabel.text = "\(account.firstname) \(account.lastname)"
        placeOfWorkLabel.text = account.placeOfWork ?? "Невідомо"
        pdfIcon.isHidden = account.linkPDF == nil
        
    }
}
