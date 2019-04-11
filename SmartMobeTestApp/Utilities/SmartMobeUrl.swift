//
//  SmartMobeUrl.swift
//  SmartMobeTextApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation

class SmartMobeurl:NSObject {
    
    static let imageorVedio = "http://www.splashbase.co/api/v1/images"
    static let searchimageVedio = "http://www.splashbase.co/api/v1/images/search"
    
    
    static let ImageVedio:String = {
        
        let url = imageorVedio + "/latest"
        return url
        
    }()
    
    static let SearchImageVedio:String = {
        let url = searchimageVedio
        return url
    }()
    
    
}
