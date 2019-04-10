//
//  View2.swift
//  PR_storyboard&Nib
//
//  Created by Hyeontae on 09/04/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class View2: UIView {

    @IBOutlet weak var centerLabel: UILabel!
//        {
//            didSet {
//                self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeNib)))
//            }
//        }
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("View2 Init one")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("View2 Init two")
    }
    
    override func awakeFromNib() {
        print("View2 awake From nib")
        centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeNib)))
    }
    
    @objc func removeNib() {
        print("Remove Nib Class")
        self.removeFromSuperview()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("View2 draw")
    }
    

}
