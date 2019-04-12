//
//  ViewController.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
   var player = AVPlayer()
   var PlayerviewController = AVPlayerViewController()
    
    
    var searching = false
    
    var imagedata: [imageList]? {
        didSet {
            tableview.reload()
        }
        
    }
    
    var searchData: [SearchData]? {
        didSet {
            tableview.reload()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        ImageVedio.requestForImageVedio(self, WithCompletion: {  (responce) in
            
            self.imagedata = responce?.image
   
        }) {
            
            print("Error")
        }
        
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            
            return searchData?.count ?? 0
        }
        else{
        return imagedata?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell
        cell?.backgroundColor = .gray
        if searching {
            cell?.imageViewCell.setURLImage(imageURL: searchData![indexPath.row].searchurl)
            let imageExtensions = ["png", "jpg", "gif"]
            let url: URL? = NSURL(fileURLWithPath: searchData![indexPath.row].searchurl!) as URL
            let pathExtention = url?.pathExtension
            if imageExtensions.contains(pathExtention!)
            {
                cell?.playBtn.isHidden = true
                
            }else
            {
                cell?.playBtn.isHidden = false
                cell?.playBtn.isUserInteractionEnabled = true
                cell?.playBtn.addTarget(self, action: #selector(self.play(_:)), for: .touchUpInside)
            }
            
        }else {
             cell?.imageViewCell.setURLImage(imageURL: imagedata![indexPath.row].url)
            let imageExtensions = ["png", "jpg", "gif"]
            let url: URL? = NSURL(fileURLWithPath: imagedata![indexPath.row].url!) as URL
            let pathExtention = url?.pathExtension
            if imageExtensions.contains(pathExtention!)
            {
                cell?.playBtn.isHidden = true
               
            }else
            {
                cell?.playBtn.isHidden = false
                cell?.playBtn.isUserInteractionEnabled = true
                cell?.playBtn.addTarget(self, action: #selector(self.play(_:)), for: .touchUpInside)
              
            }
            
        }
        
        return cell!
    }
    
    @objc  func play(_ sender : UIControl) {
        
        if searching {
              guard  let videoString = self.searchData?[sender.tag].searchlargerurl else {return}
            let videoURL = NSURL(string: videoString)
            let player = AVPlayer(url: videoURL! as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: nil)
        }else {
             guard  let videoString = self.imagedata?[sender.tag].largerurl else {return}
            let videoURL = NSURL(string: videoString)
            let player = AVPlayer(url: videoURL! as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: nil)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let DetailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if searching{
       
            DetailVc.getImage = searchData![indexPath.row].searchlargerurl!
            self.present(DetailVc, animated: true, completion: nil)

           
        }else {
            
            let imageExtensions = ["png", "jpg", "gif"]
            let url: URL? = NSURL(fileURLWithPath: imagedata![indexPath.row].largerurl!) as URL
            let pathExtention = url?.pathExtension
            if imageExtensions.contains(pathExtention!)
            {
                 DetailVc.getImage = imagedata![indexPath.row].largerurl!
                  self.present(DetailVc, animated: true, completion: nil)
             
            }else
            {
             
    
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        SearchingModel.requestToSearch(search: searchBar.text!, viewController: self, withComplection: { (searchData) in
            self.searchData = searchData?.searchdata

        }, withError: {
            print("Error")
        })
        
        searching = true
        tableview.reload()
        
    }

    
}
