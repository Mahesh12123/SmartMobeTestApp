//
//  DetailViewController.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/11/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import UIKit
//import SDWebImage

class DetailViewController: UIViewController {
    @IBOutlet var detailImage: UIImageView!
    var getImage = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImage.setURLImage(imageURL: getImage)
    }
    
    @IBAction func backAction(_ sender: Any) {
        
         let HomeVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
         self.present(HomeVc, animated: true, completion: nil)
        
    }
    
    
   

}
