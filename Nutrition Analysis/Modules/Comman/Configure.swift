//
//  Configure.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 30/03/2021.
//

import Foundation

struct Configure {
    static let shared = Configure()
    private (set) var appUrl: String!
    
   private init() {
        if appUrl == nil, let url = self.getPlist()?.object(forKey: "app_url") as? String {
            self.appUrl = url
        }
        if let appId = self.getPlist()?.object(forKey: "app_id") as? String {
            self.appUrl.append("?app_id=\(appId)")
        }
        if let key = self.getPlist()?.object(forKey: "app_key") as? String {
            self.appUrl.append("&app_key=\(key)")
        }
    }
    
    private func getPlist(withName name: String = "Config") -> NSMutableDictionary?
    {
        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? NSMutableDictionary
        }
        return nil
    }
    
}

func dLog(_ val: Any?){
    #if DEBUG
    print(val ?? "PARAMTERS IS NULL")
    #endif
}
