//
//  KategoriHeaderTableViewCell.swift
//  bltest
//
//  Created by Rian Sanjaya Ng on 05/02/19.
//  Copyright © 2019 Rian Sanjaya Ng. All rights reserved.
//

import UIKit

class KategoriHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var katBarangLabel: UILabel!
    @IBOutlet weak var lihatSemuaButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
