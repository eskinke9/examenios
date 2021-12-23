//
//  TableViewCellNotifications.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit

class TableViewCellNotifications: UITableViewCell {

    @IBOutlet weak var nameNotification: UILabel!
    @IBOutlet weak var imageNotification: UIImageView!
    @IBOutlet weak var dateNotification: UILabel!
    @IBOutlet weak var messageNotification: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
