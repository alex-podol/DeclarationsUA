//
//  NetworkLayer.swift
//  DeclarationsUA
//
//  Created by Alexander on 03.12.2020.
//

import Foundation
import Alamofire

class NetworkLayer {
    
    static func searchDeclarations(name: String, page: Int = 1) {
        
        let parameters: [String: Any] = ["page": page, "q": name]
         
        AF.request(K.ProductionServer.baseURL, method: .get, parameters: parameters).responseJSON { (jsonResponce) in
            
            do {
                try print(jsonResponce.result.get())
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
