//
//  CarDetailsViewController.swift
//  Cars
//
//  Created by Thiha Aung on 2/1/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ingressLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var titleLabelHeight: NSLayoutConstraint!
    @IBOutlet var ingressLabelHeight: NSLayoutConstraint!
    @IBOutlet var descriptionLabelHeight: NSLayoutConstraint!
    @IBOutlet var contentHeight: NSLayoutConstraint!
    
    
    var carFeed: CarFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text       = carFeed?.title
        self.dateLabel.text        = carFeed?.dateTime
        
        self.imageView.image       = UIImage(data: (carFeed?.image!)!)
        self.ingressLabel.text     = carFeed?.ingress
        self.subTitleLabel.text    = carFeed?.subject
        self.descriptionLabel.text = carFeed?.carDescription
    }
    
    override func viewWillLayoutSubviews() {
        if carFeed?.title != nil {
            self.titleLabelHeight.constant = (carFeed?.title?.height(withConstrainedWidth: self.titleLabel.frame.width, font: UIFont(name: "SFUIDisplay-Medium", size: 27)!))!
        }
        
        if carFeed?.ingress != nil {
            self.ingressLabelHeight.constant = (carFeed?.ingress?.height(withConstrainedWidth: self.ingressLabel.frame.width, font: UIFont(name: "SFUIDisplay-Regular", size: 18)!))!
        }
        
        if carFeed?.carDescription != nil {
            self.descriptionLabelHeight.constant = (carFeed?.carDescription?.height(withConstrainedWidth: self.descriptionLabel.frame.width, font: UIFont(name: "SFUIDisplay-Regular", size: 16)!))!
        }
        
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
