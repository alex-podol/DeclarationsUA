//
//  NetworkLayer.swift
//  DeclarationsUA
//
//  Created by Alexander on 03.12.2020.
//

import Foundation
import Alamofire
import SafariServices

typealias JSON = [String: Any]


class NetworkLayer {
    
    static func searchDeclarations(name: String, page: Int = 1, completion: @escaping ([AccountModel]?, PageModel?) -> Void) {
        
        let parameters: JSON = ["page": page, "q": name]
        
        AF.request(K.ProductionServer.baseURL, method: .get, parameters: parameters).responseJSON { (jsonResponce) in
            
            do {
                
                if let jsonValue = try jsonResponce.result.get() as? JSON,
                   let jsonItems = jsonValue["items"],
                   let jsonPage = jsonValue["page"] {
                    
                    let decoder = JSONDecoder()
                    
                    if let itemsData = try? JSONSerialization.data(withJSONObject: jsonItems, options: []),
                       let pageData = try? JSONSerialization.data(withJSONObject: jsonPage, options: []) {
                        
                        let itemsArray = try? decoder.decode([AccountModel].self, from: itemsData)
                        let page = try? decoder.decode(PageModel.self, from: pageData)
                        
                        completion(itemsArray, page) // после окончания работы метода на выход передаем эти два обекта
                    }
                } else {
                    completion(nil, nil)
                }
                
            } catch {
                print("Find \(error.localizedDescription)")
            }
        }
    }
    
    static func getSafariViewController(urlString: String) -> SFSafariViewController? {
        
        if let reportURL = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: reportURL)
            return safariVC
        } else {
            return nil
        }
    }
    
    
    
}
