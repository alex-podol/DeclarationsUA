//
//  ActivityTableViewCell.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // идентификатор ячейки и xib-файла по имени экземпляра класса
    static var identifier: String {
        return String(describing: self)
    }
    
}
