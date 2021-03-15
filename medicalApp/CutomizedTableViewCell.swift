//
//  CutomizedTableViewCell.swift
//  medicalApp
//
//  Created by Vyom Unadkat on 3/5/21.
//

import UIKit

import InstaZoom
class CutomizedTableViewCell: UITableViewCell {

    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var mytag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
