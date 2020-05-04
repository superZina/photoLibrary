//
//  CustomView.swift
//  photoLibrary
//
//  Created by 이진하 on 2020/05/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
