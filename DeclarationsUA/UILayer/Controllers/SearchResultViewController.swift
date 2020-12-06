//
//  SearchResultViewController.swift
//  DeclarationsUA
//
//  Created by Alexander on 06.12.2020.
//


import UIKit

class SearchResultViewController: UIViewController {
    
    var nameForSearch: String = ""
    var currentPage: PageModel?
    var isLoadingNow = false
    
    var foundAccounts: [AccountModel] = [] {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // связываем таблицу с контролером
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: AccountTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AccountTableViewCell.identifier)
        
        makeNetworkRequest(errorHandler: nil)
    }
    
    func makeNetworkRequest(errorHandler: (() -> Void)?) {
        if !isLoadingNow {
            isLoadingNow = true
            
            NetworkLayer.searchDeclarations(name: nameForSearch) { (accounts, page) in
                self.isLoadingNow = false
                if let accounts = accounts,
                   let page = page {
                    
                    self.currentPage = page
                    self.foundAccounts += accounts
                }
            }
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier) as? AccountTableViewCell
        cell?.setup(with: foundAccounts[indexPath.row])
        
        return cell!
    }
    
    
}



