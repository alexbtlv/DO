//
//  DOTaskProgressView.swift
//  DO
//
//  Created by Alexander Batalov on 3/26/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit

@IBDesignable class DOTaskProgressView: UIView {
    
    @IBInspectable var totalNumberOfTasks: CGFloat = 10
    @IBInspectable var numberOfTasksToDisplay: CGFloat = 4
    @IBInspectable var statusText: String = "snoozed"
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let upCaseString = statusText.uppercaseString
        DOStyleKit.drawDOTaskProgressView(numberOfTasksToDisplay, numberOfTasksTotal: totalNumberOfTasks, statusText: upCaseString)
    }
    
}
