//
//  CalendarViewController.swift
//  DO
//
//  Created by Alexander Batalov on 3/12/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit
//import SWRevealViewController

class CalendarViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.revealViewController().rearViewRevealWidth = view.frame.width - Constants.swRevealFrontViewControllerWidth
//        self.revealViewController().toggleAnimationType = SWRevealToggleAnimationType.Spring
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
