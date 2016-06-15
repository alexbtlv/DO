//
//  CalendarViewController.swift
//  DO
//
//  Created by Alexander Batalov on 3/12/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit
import CVCalendar
import SWRevealViewController

class CalendarViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    var menuView: CVCalendarMenuView!
    var calView: CVCalendarView!
    var monthLabel: UILabel!
    var animationFinished = true
    
    var selectedDay:DayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.revealViewController().rearViewRevealWidth = view.frame.width - Constants.swRevealFrontViewControllerWidth
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 76
        
        // CVCalendarMenuView initialization with frame
        menuView = CVCalendarMenuView()
        menuView.dayOfWeekTextColor = UIColor(white: 1, alpha: 0.5)
        menuView.dayOfWeekFont = UIFont(name: "Avenir-Book", size: 13)!
        menuView.dayOfWeekTextUppercase = false
        // CVCalendarView initialization with frame
        calView = CVCalendarView()
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
    
    override func viewWillLayoutSubviews() {
        calView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            menuView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8),
            menuView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 15),
            menuView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: 15),
            menuView.heightAnchor.constraintEqualToConstant(25),
            
            calView.topAnchor.constraintEqualToAnchor(menuView.bottomAnchor, constant: 15),
            calView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 15),
            calView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: 15),
            calView.heightAnchor.constraintEqualToConstant(300)
        ])
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
    
    // MARK: – Actions
    
    @IBAction func prevNavBarButtonTapped(sender: AnyObject) {
        calView.loadPreviousView()
    }
    
    @IBAction func nextNavBarButtonTapped(sender: AnyObject) {
        calView.loadNextView()
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

extension CalendarViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell")! as UITableViewCell
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate {
}



