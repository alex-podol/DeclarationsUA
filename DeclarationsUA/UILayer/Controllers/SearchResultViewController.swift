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
        
        // наблюдатель за массивом записей
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
        
        tableView.register(UINib(nibName: ActivityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActivityTableViewCell.identifier)
        
        makeNetworkRequest {
            
            let alert = UIAlertController(title: "Помилка", message: "По Вашому запиту нічого не знайдено", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Зрозуміло", style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func makeNetworkRequest(errorHandler: (() -> Void)?) {
        if !isLoadingNow {
            isLoadingNow = true
            
            NetworkLayer.searchDeclarations(name: nameForSearch) { (accounts, page) in
                self.isLoadingNow = false
                if let accounts = accounts,
                   let page = page {
                    self.currentPage = page
                    self.title = "Знайдено \(page.totalItems)"
                    self.foundAccounts += accounts
                } else {
                    errorHandler?()
                }
            }
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentPage == nil {
            return 2
        }
        
        if let currentPage = currentPage {
            if let totalItems = Double(currentPage.totalItems) {
                let maximumPage = (totalItems / Double(currentPage.batchSize)).rounded(.up)
                return maximumPage > Double(currentPage.currentPage) ? 2 : 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? foundAccounts.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // если вторая секция, то выводим пагинатор с индикатором активности
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier) as? ActivityTableViewCell
            cell?.activityIndicator.startAnimating()
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier) as? AccountTableViewCell
        cell?.setup(with: foundAccounts[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            makeNetworkRequest(errorHandler: nil)
        }
    }
    
}
