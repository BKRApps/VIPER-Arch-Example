//
//  IndexSearchCell.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import UIKit

class IndexSearchCell: UITableViewCell {
    
    @IBOutlet weak var indexName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureIndexSeacrchCell(indexName:String){
        self.indexName.text=indexName
    }

}
