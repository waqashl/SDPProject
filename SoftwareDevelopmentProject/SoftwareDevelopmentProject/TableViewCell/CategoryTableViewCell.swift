//
//  CategoryTableViewCell.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/26/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
