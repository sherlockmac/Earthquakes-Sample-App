//
//  ListTableCell.swift
//  Earthquakes Sample App
//
//  Copyright © 2016 Ali Afghah. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {

    
    @IBOutlet var eqid: UILabel!
    @IBOutlet var src: UILabel!
    @IBOutlet var depth: UILabel!
    @IBOutlet var magnitude: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var magImage: UIImageView!
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
