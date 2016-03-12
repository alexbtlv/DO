//
//  NavigationTableViewController.swift
//  DO
//
//  Created by Alexander Batalov on 3/12/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit

class NavigationTableViewController: UITableViewController {
    
    let heightForHeaderInSection1: CGFloat = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return heightForHeaderInSection1
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: heightForHeaderInSection1))
     
            let separatorView = UIImageView(image: UIImage(named: "menuSeparator")!)
            separatorView.frame = CGRect(x: 0, y: 24.5, width: view.frame.width - Constants.swRevealFrontViewControllerWidth, height: 1)
            
            header.addSubview(separatorView)
            return header
        } else {
            return nil
        }
    }

}
