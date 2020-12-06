//
//  SearchResultViewController.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//


//NetworkLayer.searchDeclarations(name: "Мальований") { (resultArray, page) in
//
//    print(page)
//    //print(resultArray)
//
//}




import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // связываем таблицу с контролером
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountTableViewCell")
    }
    
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell
        cell?.textLabel?.text = String(describing: indexPath.row)
        return cell!
    }
    
    
}



