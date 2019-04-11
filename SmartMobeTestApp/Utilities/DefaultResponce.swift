//
//  DefaultResponce.swift
//  SmartMobeTextApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import ObjectMapper

protocol MappableExtended:Mappable {
    var imageString:String?{get}
   
}

class DefaultResponce:NSObject ,NSCoding ,MappableExtended{
   
    
    var imageString: String?
    
//    var imgSt:String? {
//        get{
//            return imageString
//        }
//    }
  
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(map: Map) {
      
    }
    
    func mapping(map: Map) {
        
       imageString <- map[""]
        
        
    }
    
    
}
