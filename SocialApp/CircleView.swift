//
//  CircleView.swift
//  SocialApp
//
//  Created by Wojciech Charuza on 11.11.2016.
//  Copyright © 2016 Wojciech Charuza. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2

}
}
