//
//  HouseCell.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

class HouseCell: UITableViewCell {

    static let reuseIdentifier = String(describing: self)

    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        sigilImageView.image = nil
        nameLabel.text = nil
        wordsLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
