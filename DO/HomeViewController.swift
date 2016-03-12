//
//  ViewController.swift
//  DO
//
//  Created by Alexander Batalov on 12/23/15.
//  Copyright © 2015 Alexander Batalov. All rights reserved.
//

import UIKit
import SWRevealViewController

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.revealViewController().rearViewRevealWidth = view.frame.width - Constants.swRevealFrontViewControllerWidth
        self.revealViewController().toggleAnimationType = SWRevealToggleAnimationType.Spring
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
    }
    
    // MARK: – Action Methods
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        print("Add ToDo button tapped")
    }
}

extension HomeViewController: UITableViewDataSource {
    
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

extension HomeViewController : UITableViewDelegate {
}

