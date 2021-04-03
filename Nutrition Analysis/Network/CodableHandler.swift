//
//  CodableHandler.swift
//  SayAllo
//
//  Created by Yahia El-Dow on 2/6/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import SwiftyJSON
struct CodableHandler {
    
    static func decode<T : Decodable>(_ type: T.Type, from jsonObject: JSON) -> Any?
    {
        do {
            let data = jsonObject.description.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let contactModel = try jsonDecoder.decode( type,from: data ??  Data() )
            return contactModel
        }catch let caught as NSError {
            dLog(caught)
            return nil
        }
    }
    
    static func encode<T : Encodable>(_ type: T) -> [String : Any]?
    {
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(type)
            let jsonEncode =  try JSONSerialization.jsonObject(with: jsonData) //String(data: jsonData, encoding: .utf8) ?? ""
            return jsonEncode as? [String : Any]
        }catch let caught as NSError {
            dLog(caught)
            return nil
        }
        
    }
    
    static func decodeClass<T : Decodable>(_  type: T.Type , classJsonData : JSON) -> Any?{
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: classJsonData.rawData())
        return modelClass ?? nil
    }
    
    
    
}
