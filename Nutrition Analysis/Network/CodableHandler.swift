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
    static func decodeClass<T : Decodable>(_  type: T.Type , classJsonData : JSON) -> Any?{
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: classJsonData.rawData())
        return modelClass ?? nil
    }
}
