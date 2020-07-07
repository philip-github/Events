//
//  APIManager.swift
//  Events
//
//  Created by Philip Twal on 5/23/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import Foundation


class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    typealias EventCompletionHandler = ([Event]?,Error?) -> Void
    
    
    func callLocalData() -> Data?{
        do{
            if let bundlePath = Bundle.main.path(forResource: "mock", ofType: "json"){
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
                return jsonData
            }
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    func parseLocalData(jsonData : Data, completionHandler : @escaping EventCompletionHandler){
        
        do{
            let decodedData = try JSONDecoder().decode([Event].self, from: jsonData)
            completionHandler(decodedData,nil)
        }catch{
            print(error.localizedDescription)
            completionHandler(nil,error)
        }
        
    }
}
