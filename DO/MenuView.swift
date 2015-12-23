//
//  MenuView.swift
//  DO
//
//  Created by Alexander Batalov on 12/24/15.
//  Copyright © 2015 Alexander Batalov. All rights reserved.
//

import UIKit

@IBDesignable class MenuView: UIView {

    override func drawRect(rect: CGRect) {
        DOStyleKit.drawMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
}
