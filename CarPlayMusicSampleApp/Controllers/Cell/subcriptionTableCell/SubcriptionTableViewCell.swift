//
//  SubcriptionTableViewCell.swift
//  CarPlayMusicSampleApp
//
//  Created by mac on 29/08/24.
//

import UIKit

class SubcriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleBtn: UIButton!
    @IBOutlet weak var freeTrailBtn: UIButton!
    @IBOutlet weak var rightClickBTn: UIButton!
    @IBOutlet weak var backGrundView: UIView!
    @IBOutlet weak var labelMonth_week: UILabel!
    @IBOutlet weak var for30DaysLbl: UILabel!
    @IBOutlet weak var termConditionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        circleBtn.tintColor = .white
//        freeTrailBtn.setTitleColor(.white, for: .normal)
//        labelMonth_week.textColor = .white
//        for30DaysLbl.textColor = .white
//        termConditionLbl.textColor = .white
//        backGrundView.backgroundColor = UIColor.themeColor

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            circleBtn.tintColor = .white
            freeTrailBtn.setTitleColor(.white, for: .normal)
            labelMonth_week.textColor = .white
            for30DaysLbl.textColor = .white
            termConditionLbl.textColor = .white
            backGrundView.backgroundColor = UIColor.themeColor
        } else {
            circleBtn.tintColor = .black
            freeTrailBtn.setTitleColor(.black, for: .normal)
            labelMonth_week.textColor = .black
            for30DaysLbl.textColor = .darkGray
            termConditionLbl.textColor = .darkGray
            backGrundView.backgroundColor = .white
        }
        
        // Force layout update
        freeTrailBtn.layoutIfNeeded()
    }
}
