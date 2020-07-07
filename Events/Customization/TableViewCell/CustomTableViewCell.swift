//
//  CustomTableViewCell.swift
//  Events
//
//  Created by Philip Twal on 5/23/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func populate(eventLabel: String, startLabel: String, endLabel: String){
        
        self.eventLabel.text = eventLabel
        self.startLabel.text = startLabel
        self.endLabel.text = endLabel
    }

}
