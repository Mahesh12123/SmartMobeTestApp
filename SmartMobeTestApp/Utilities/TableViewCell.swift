//
//  TableViewCell.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/10/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imageViewCell: UIImageView!
    
    @IBOutlet var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      //  playBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
