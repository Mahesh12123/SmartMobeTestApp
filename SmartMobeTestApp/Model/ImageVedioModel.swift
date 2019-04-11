//
//  ImageVedioModel.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class ImageVedio:DefaultResponce {
    
    var image :[imageList]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    override func mapping(map: Map) {
        super.mapping(map: map)
        image <- map["images"]
        
        
    }
    
    class func requestForImageVedio(_ viewController:UIViewController , WithCompletion completion:@escaping(ImageVedio?) ->(), withError error:@escaping()->()) {
        
        APIManager(urlString: SmartMobeurl.ImageVedio, method: .get).HandleResponce( viewController: viewController, completionHandler: { (responceimage:ImageVedio) in
            
            print("responce ==\(responceimage)")
            completion(responceimage)
            
            
        }) { (failure) in
            error()
        }
        
    }
    
}

class imageList: Mappable {
      var id:Int = 0
      var url:String?
      var largerurl:String?
      var sourceid:Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
      func mapping(map: Map) {
        
        id <- map["id"]
        url <- map["url"]
        largerurl <- map["large_url"]
        sourceid <- map["source_id"]
        
        
    }
    
    
}

