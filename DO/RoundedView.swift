//
//  RoundedView.swift
//  DO
//
//  Created by Alexander Batalov on 3/10/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit

@IBDesignable class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
