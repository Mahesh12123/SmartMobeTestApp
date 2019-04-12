//
//  ImageExtension.swift
//  SmartMobeTextApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


extension UIImageView {
    
    func setURLImage(imageURL:String? ,placeHolder defaultImage:String = "placeHolder") {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(UIActivityIndicatorView.Style.whiteLarge)
        if imageURL != nil {
            self.sd_setImage(with: URL.init(string: imageURL!), placeholderImage: UIImage.init(named: defaultImage), options:SDWebImageOptions.scaleDownLargeImages, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, url: URL?) in
                
                if ((error) != nil) {
                    self.image = UIImage.init(named: defaultImage)
                }
            })
        }
        else{
            self.image = UIImage.init(named: defaultImage)
        }
        
    }
    

    
}
