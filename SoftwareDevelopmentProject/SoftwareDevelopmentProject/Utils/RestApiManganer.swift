//
//  RestApiManganer.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/24/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation
import Alamofire


class RestApiManager {
    static let sharedInstance = RestApiManager()
    
    //localHostUrlapi  192.168.0.30
    let baseURL = "http://192.168.0.30:2000/"
    
    private init() {}
    
    
    func makeGetRequest(vc:BaseViewController?, url:String, params: Parameters?,  successCompletionHandler: @escaping (Any?) -> Swift.Void, failureCompletionHandler: @escaping (Any?) -> Swift.Void){
        if vc != nil
        {
            vc!.showLoading()
        }
        let apiEndpoint = URL(string: baseURL + url)!
        
        var headers = HTTPHeaders()
        
        if(Globals.sharedInstance.userToken != nil){
            headers = [.authorization(bearerToken: Globals.sharedInstance.userToken!)]
        }
        
        AF.request(apiEndpoint, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers,
                   interceptor: nil).responseJSON { (response) in
                    
                    if vc != nil
                    {
                        vc!.hideLoading()
                    }
                    
                    guard let data = response.value else { return }
                    
                    switch response.result {
                    case .success:
                        return successCompletionHandler(data)
                        
                    case .failure(let error):
                        print(error)
                        return failureCompletionHandler(data)
                    }
                    
        }
    }
    
    
    func makePostRequest(vc:BaseViewController?, url:String, params :Parameters, successCompletionHandler: @escaping (Any?) -> Swift.Void, failureCompletionHandler: @escaping (Any?) -> Swift.Void){
        
        if vc != nil
        {
            vc!.showLoading()
        }
        
        let apiEndpoint = URL(string: baseURL + url)!
        
        var headers = HTTPHeaders()
        
        if(Globals.sharedInstance.userToken != nil){
            headers = [.authorization(bearerToken: Globals.sharedInstance.userToken!)]
        }
        
        
        AF.request(apiEndpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers,
                   interceptor: nil).responseJSON { (response) in
                    
                    if vc != nil
                    {
                        vc!.hideLoading()
                    }
                    
                    guard let data = response.value else { return }
                    
                    switch response.result {
                    case .success:
                        return successCompletionHandler(data)
                        
                    case .failure(let error):
                        print(error)
                        return failureCompletionHandler(data)
                    }
                    
        }
        
    }
    
    
    
    //    Multi part upload
    //    Alamofire.URLRequestConvertible
    func uploadMultipartData(vc: BaseViewController? ,images: [Data], to url: String , params: [String: Any], successCompletionHandler: @escaping (Any?) -> Swift.Void, failureCompletionHandler: @escaping (Any?) -> Swift.Void) {
        
        if vc != nil {
            vc!.showLoading()
        }
        
        let apiEndpoint = baseURL+url
        var headers = HTTPHeaders()
        
        if(Globals.sharedInstance.userToken != nil){
            headers = [.authorization(bearerToken: Globals.sharedInstance.userToken!)]
        }
        
        AF.upload(multipartFormData: { (multiPart) in
            for (key, value) in params {
                //params
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
            }
            for i in images {
                multiPart.append(i, withName: "images", fileName: "\(String(describing: params["title"]!))\(Int.random(in: 0..<99999)).png", mimeType: "image/png")
            }
            
        }, to: apiEndpoint, method: .post, headers: headers)
            .responseJSON { (response) in
                
                if vc != nil {
                    vc!.hideLoading()
                }
                
                guard let data = response.value else { return }
                
                switch response.result {
                case .success:
                    return successCompletionHandler(data)
                    
                case .failure(let error):
                    print(error)
                    return failureCompletionHandler(data)
                }
        }
        
        
    }

    
}
