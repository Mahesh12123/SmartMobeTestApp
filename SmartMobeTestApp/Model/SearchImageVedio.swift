//
//  SearchImageVedio.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/11/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire

class SearchingModel:DefaultResponce {
    
    var searchdata :[SearchData]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        searchdata <- map["images"]
        
        
    }
    
    
    class func requestToSearch( search:String ,viewController:UIViewController, withComplection completion:@escaping (SearchingModel?) ->(),withError error:@escaping () ->()) {
        
        let params = ["query":search]
        APIManager(urlString: SmartMobeurl.searchimageVedio, parameters: params,  method: .get).HandleResponce( viewController: viewController, progressMessage: "Searching", completionHandler: { (responce:SearchingModel) in
            
            completion(responce)
            
        }) { (failure) in
            error()
        }
        
    }
    
}

class SearchData : Mappable {
   
    var searchid:Int = 0
    var searchurl:String?
    var searchlargerurl:String?
    var searchsourceid:Int = 0
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
    
        searchid <- map["id"]
        searchurl <- map["url"]
        searchlargerurl <- map["large_url"]
        searchsourceid <- map["source_id"]
    
    }
    
    
    
}
