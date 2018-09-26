//
//  CarFeedCellTableViewCell.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class CarFeedCellTableViewCell: UITableViewCell {

    @IBOutlet var carImageView      : UIImageView!
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var dateLabel         : UILabel!
    @IBOutlet var ingressLabel      : UILabel!
    @IBOutlet var goToDetailButton  : UIButton!
    @IBOutlet var gradientView      : UIView!
    @IBOutlet var ingressLabelHeight: NSLayoutConstraint!
    @IBOutlet var titleLabelHeight  : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let gradientLayer   = CAGradientLayer()
        gradientLayer.frame = self.gradientView.bounds
        let color1 = UIColor(red: 1/255.0, green: 1/255.0, blue: 1/255.0, alpha: 1)
        let color2 = UIColor(red: 1/255.0, green: 1/255.0, blue: 1/255.0, alpha: 0.0)
        gradientLayer.colors    = [color2.cgColor, color1.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.gradientView.layer.addSublayer(gradientLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
