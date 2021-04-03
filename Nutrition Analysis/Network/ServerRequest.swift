
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
    enum FailureReason: Int, Error {
        case defualt = 0
        case unAuthorized = 401
        case notFound = 404
        case unprocessableEntity = 422
        case recipeError = 555
    }
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
                    Result(FailureReason(rawValue: statusCode ?? 0) , statusCode ?? 0, error)
                    return
                case .success(let requestResult):
                    Result(requestResult, statusCode ?? 0, nil)
                    return
                }
            })
    }
    
}
