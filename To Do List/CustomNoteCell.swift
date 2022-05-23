//
//  CustomNoteCell.swift
//  To Do List
//
//  Created by Burak Yılmaz on 23.05.2022.
//

import UIKit

class CustomNoteCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var noteText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
