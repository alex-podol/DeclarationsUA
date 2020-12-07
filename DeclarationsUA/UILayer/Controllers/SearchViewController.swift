//
//  SearchViewController.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//

import UIKit
import SafariServices // для использования browser Safari

class SearchViewController: UIViewController {

    @IBOutlet weak var nameFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameFieldOutlet.delegate = self
        
    }
    
    @IBAction func searchButtonAction() {
        performSegue(withIdentifier: "showResult", sender: nil)
        
    }
    
    @IBAction func reportButtonAction() {
        
        if let reportURL = URL(string: K.ProductionServer.reportCorruptionURL) {
            
            let safariVC = SFSafariViewController(url: reportURL)
            
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    // скрываем длинное название кнопки Back
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showResult" {
            
            let destination = segue.destination as? SearchResultViewController
            
            // передача ФИО ил должности далее для поиска
            destination?.nameForSearch = nameFieldOutlet.text ?? ""
            
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    // по нажатию клавиши Enter переходим на представление с результатами поиска
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonAction()
        return true
    }
    
    
}
