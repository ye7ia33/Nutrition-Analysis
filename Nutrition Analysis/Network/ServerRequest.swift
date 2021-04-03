
//
//  ServerRequest.swift
//  Created by Yahia El-Dow on 6/24/17.
//  Copyright © 2017 Production Code. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// ALAMO FIRE NETWORK
class AFN : NSObject {
    
    fileprivate lazy var urlEncoding = JSONEncoding.default
    fileprivate static var headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
    
    class func request (requestURL : String = Configure.shared.appUrl,
                        httpMethod: HTTPMethod = .get ,
                        paramter : [String : Any]? = nil ,
                        Result:@escaping(_ result : Any? ,_ responseCode : Int , _ errorMessage : Error?)->()) {
        let urlEncoding = requestURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? requestURL
        AF.request(urlEncoding,
                   method: httpMethod ,
                   parameters: paramter ,
                   encoding:  JSONEncoding.prettyPrinted ,
                   headers: headers )
            .validate(statusCode: 200..<400)
            .responseJSON(completionHandler: {
                response in
                let statusCode = response.response?.statusCode
                switch response.result
                {
                case .failure(let error) :
                    Result(nil , statusCode ?? 0, error)
                    return
                    
                case .success(let requestResult):
                    Result(requestResult, statusCode ?? 0, nil)
                    return
                }
            })
    }
    
}
/*
 Fresh Ham Roasted With Rye Bread and Dried Fruit Stuffing
 
1 fresh ham, about 18 pounds, prepared by your butcher (See Step 1)",
7 cloves garlic, minced
1 tablespoon caraway seeds, crushed
4 teaspoons salt
Freshly ground pepper to taste
1 teaspoon olive oil
1 medium onion, peeled and chopped
3 cups sourdough rye bread, cut into 1/2-inch cubes
1 1/4 cups coarsely chopped pitted prunes
1 1/4 cups coarsely chopped dried apricots
1 large tart apple, peeled, cored and cut into 1/2-inch cubes
2 teaspoons chopped fresh rosemary
1 egg, lightly beaten
1 cup chicken broth, homemade or low-sodium canned
*/
