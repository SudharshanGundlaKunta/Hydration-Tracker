//
//  WaterTakenTableViewCell.swift
//  HydrationTracker
//
//  Created by Sudharshan on 15/06/24.
//

import UIKit

class WaterTakenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var intakeMeasureLabel: UILabel!
    @IBOutlet weak var intakeDate: UILabel!
    @IBOutlet weak var bottleImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var editButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configureUI() {
        
        bgView.layer.cornerRadius = 8
        bgView.backgroundColor = UIColor.tertiarySystemGroupedBackground
        bgView.layer.shadowOpacity = 0.6
        bgView.layer.shadowColor = UIColor.gray.cgColor
        
        
    }
    
}
