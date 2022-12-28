//
//  CustomCell.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 15.11.2022.
//

import UIKit



class CustomCell: UITableViewCell {

    @IBOutlet weak var dogView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
