//
//  NoteCardViewCell.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import UIKit

class NoteCardViewCell: UITableViewCell {

    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
