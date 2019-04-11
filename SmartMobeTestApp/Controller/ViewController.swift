//
//  ViewController.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var searchImage = [String]()
    
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
            
        }else {
             cell?.imageViewCell.setURLImage(imageURL: imagedata![indexPath.row].url)
            
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let DetailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if searching{
        DetailVc.getImage = searchData![indexPath.row].searchlargerurl!
        }else {
              DetailVc.getImage = imagedata![indexPath.row].largerurl!
        }
        
        self.present(DetailVc, animated: true, completion: nil)
        
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
