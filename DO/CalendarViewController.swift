//
//  CalendarViewController.swift
//  DO
//
//  Created by Alexander Batalov on 3/12/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    var menuView: CVCalendarMenuView!
    var calView: CVCalendarView!
    var monthLabel: UILabel!
    var animationFinished = true
    
    var selectedDay:DayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.revealViewController().rearViewRevealWidth = view.frame.width - Constants.swRevealFrontViewControllerWidth
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
    
        // CVCalendarMenuView initialization with frame
        menuView = CVCalendarMenuView(frame: CGRect(x: 15, y: 79, width: 345, height: 25))
        menuView.dayOfWeekTextColor = UIColor(white: 1, alpha: 0.5)
        menuView.dayOfWeekFont = UIFont(name: "Avenir-Book", size: 13)!
        menuView.dayOfWeekTextUppercase = false
        // CVCalendarView initialization with frame
        calView = CVCalendarView(frame: CGRect(x: 15, y: 134, width: 345, height: 300))
        // Appearance delegate [Unnecessary]
        self.calView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calView.animatorDelegate = self
        
        // Calendar delegate [Required]
        self.calView.calendarDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        
        view.addSubview(menuView)
        view.addSubview(calView)
        
        calView.appearance.dayLabelWeekdaySelectedBackgroundColor = UIColor.whiteColor()
        calView.appearance.dayLabelWeekdaySelectedBackgroundAlpha = 0.1
        calView.appearance.dayLabelPresentWeekdayHighlightedBackgroundColor = UIColor.whiteColor()
        calView.appearance.dayLabelPresentWeekdayHighlightedBackgroundAlpha = 0.1
        
        monthLabel.text = CVDate(date: NSDate()).globalDescription
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension CalendarViewController : CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarViewController : CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayInTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func dayLabelPresentWeekdayFont() -> UIFont {
        return UIFont(name: "Avenir-Book", size: 10)!
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
}




