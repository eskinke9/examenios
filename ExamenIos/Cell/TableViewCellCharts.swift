//
//  TableViewCellCharts.swift
//  ExamenIos
//
//  Created by Moti on 22/12/21.
//

import UIKit
import Charts

class TableViewCellCharts: UITableViewCell {
    @IBOutlet weak var titleChart: UILabel!
    @IBOutlet weak var viewChart: PieChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
