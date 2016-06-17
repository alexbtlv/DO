//
//  NewEventViewController.swift
//  DO
//
//  Created by Alexander Batalov on 6/13/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "Avenir-Book", size: 17)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        dismissViewController()
    }
    
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }

}
