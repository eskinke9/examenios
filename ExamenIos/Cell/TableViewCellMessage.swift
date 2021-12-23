//
//  TableViewCellMessage.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit

class TableViewCellMessage: UITableViewCell {

    @IBOutlet weak var nameMessage: UILabel!
    @IBOutlet weak var messageMessage: UILabel!
    @IBOutlet weak var dateMessage: UILabel!
    @IBOutlet weak var imageMessage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
