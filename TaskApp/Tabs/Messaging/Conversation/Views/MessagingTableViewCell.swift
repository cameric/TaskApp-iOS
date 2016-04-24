//
//  MessagingTableViewCell.swift
//  TaskApp
//
//  Created by Cam on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit

class MessagingTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var conversation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
