//
//  MusicDetailsTableViewCell.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import UIKit

class MusicDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songSinger: UILabel!
    @IBOutlet weak var songName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
