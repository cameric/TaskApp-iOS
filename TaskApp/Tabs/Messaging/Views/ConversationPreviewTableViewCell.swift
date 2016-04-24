//
//  ConversationTableViewCell.swift
//  TaskApp
//
//  Created by Cam on 3/31/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit

class ConversationPreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var conversation: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
