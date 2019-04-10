//
//  View1.swift
//  PR_storyboard&Nib
//
//  Created by Hyeontae on 09/04/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class View1: UIView {
    
    @IBOutlet weak var centerLabel: UILabel!
    
    private let xibName: String = "View1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("View1 init one")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let nibView = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView {
            self.addSubview(nibView)
            nibView.frame = bounds
            
            layer.cornerRadius = 10.0
            layer.masksToBounds = true
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.black.cgColor
            
            heightAnchor.constraint(equalToConstant: 100).isActive = true
            widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            translatesAutoresizingMaskIntoConstraints = false
        }
        print("View1 init two")
    }
    
    override func awakeFromNib() {
        print("View1 awake From nib")
        centerLabel.text = "View1"
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("View1 draw")
    }
    

}
