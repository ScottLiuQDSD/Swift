//
//  JieTableViewCell.swift
//  Smashtag
//
//  Created by LiuScott on 15-4-15.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class JieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var JieVideoImg : UIImageView!
    @IBOutlet weak var JieVideoTitle : UILabel!
    @IBOutlet weak var JieVideoSubTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
