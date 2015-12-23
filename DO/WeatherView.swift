//
//  WeatherView.swift
//  DO
//
//  Created by Alexander Batalov on 12/24/15.
//  Copyright © 2015 Alexander Batalov. All rights reserved.
//

import UIKit

@IBDesignable class WeatherView: UIView {
    
    @IBInspectable var temperature: CGFloat = 67 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        DOStyleKit.drawWeather(temperature: temperature)
    }
}
