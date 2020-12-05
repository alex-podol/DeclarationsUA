 //
//  ViewController.swift
//  DeclarationsUA
//
//  Created by Alexander on 03.12.2020.
//

 import UIKit
 
 class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkLayer.searchDeclarations(name: "Мальований") { (resultArray, page) in
            
            print(page)
            //print(resultArray)
            
        }
        
        
        
    }
    
    
 }

