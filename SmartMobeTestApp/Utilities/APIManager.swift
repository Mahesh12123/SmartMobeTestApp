//
//  APIManager.swift
//  SmartMobeTextApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SVProgressHUD


public class APIManager{
    
    var request:DataRequest!
    
    public init(urlString:String , parameters:Parameters? = nil , headers:[String:String] = [String:String](), method: Alamofire.HTTPMethod = .post , encoding:JSONEncoding? = nil ) {
        
        let header = headers ,  parameter = parameters
        
        //        if let logindata = UserLogInfo.getUserinfo(),
        //
        //            let logintoken = logindata.token {
        //
        //                 header["Authorization"] = "Bearer " + logintoken
        //
        //        }
        
        self.request = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameter, encoding: encoding != nil ? JSONEncoding.default : URLEncoding.default, headers: header)
        
    }
    
    func HandleResponce<T: DefaultResponce>(isFirstCall:Bool? = true , showindicator indicator:Bool? = true , viewController:UIViewController? = nil , progressMessage:String? = nil , isSynching sync:Bool? = false ,completionHandler:@escaping(T) -> Void , errorBlock:((T) -> Void)? = nil , failureBlock:((String) -> Void)? = nil  ) {
        
         ProgressHud.showSuccessHUD(progressMessage, withBg: true)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 500
        configuration.timeoutIntervalForResource = 500
        _ = Alamofire.SessionManager(configuration: configuration)
        _ = self.request.responseObject(completionHandler: { (responce:DataResponse<T>) in
            
            
            switch responce.result{
                
            case.success(let dataX):
                
                 completionHandler(dataX)

            case .failure( let error):
                
                ProgressHud.hideProgressHUD()
                print(error)
                
                failureBlock?("server erorr")
            }
            
        })
        
    }
    
}


class ProgressHud: NSObject {
    class func showProgressHUD(_ msg:String? = nil, withBg:Bool? = false ){
        
        if let msg = msg {
            SVProgressHUD.show(withStatus: msg)
        } else {
            SVProgressHUD.show()
        }
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor (UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setRingNoTextRadius(20)
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
    }
    
    class func hideProgressHUD(){
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    class func showSuccessHUD(_ msg:String? = nil, withBg:Bool? = false ){
        
        if let msg = msg {
            SVProgressHUD.showSuccess(withStatus: msg)
            
        } else {
            SVProgressHUD.showSuccess(withStatus: nil)
        }
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor (UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setRingNoTextRadius(20)
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
    }
    
}
