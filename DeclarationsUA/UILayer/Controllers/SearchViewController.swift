//
//  SearchViewController.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet fileprivate weak var nameFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameFieldOutlet.delegate = self
        
    }
    
    @IBAction private func searchButtonAction() {
        performSegue(withIdentifier: "showResult", sender: nil)
        
    }
    
    @IBAction private func reportButtonAction() {
        
        if let safariVC = NetworkLayer.getSafariViewController(urlString: K.ProductionServer.reportCorruptionURL) {
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
    
    @IBAction private func toNazkSite(_ sender: UIBarButtonItem) {
        if let safariVC = NetworkLayer.getSafariViewController(urlString: K.ProductionServer.nazkSite) {
            self.present(safariVC, animated: true, completion: nil)
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
