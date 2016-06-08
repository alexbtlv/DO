//
//  ListsViewController.swift
//  DO
//
//  Created by Alexander Batalov on 3/29/16.
//  Copyright © 2016 Alexander Batalov. All rights reserved.
//

import UIKit
import SWRevealViewController

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.revealViewController().rearViewRevealWidth = view.frame.width - Constants.swRevealFrontViewControllerWidth
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "Avenir-Book", size: 17)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]

        let headerHeight = navigationController!.navigationBar.frame.height + headerView.frame.height
        let scrollViewHeight = view.frame.height - headerHeight
        let scrollViewWidth = view.frame.width
        
        let tableView1 = UITableView(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        tableView1.backgroundColor = UIColor.yellowColor()
        let tableView2 = UITableView(frame: CGRect(x: scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        tableView2.backgroundColor = UIColor.brownColor()
        let tableView3 = UITableView(frame: CGRect(x: scrollViewWidth*2, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        tableView3.backgroundColor = UIColor.cyanColor()
        
        scrollView.contentSize = CGSize(width: scrollViewWidth*3, height: scrollViewHeight)
        scrollView.addSubview(tableView1)
        scrollView.addSubview(tableView2)
        scrollView.addSubview(tableView3)
        
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
    
    // MARK: - Action Handlers
    @IBAction func previousListButtonTapped(sender: AnyObject) {
        if scrollView.contentOffset.x != 0 {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x - view.frame.width, y: 0), animated: true)
        }
    }
    
    @IBAction func nextListButtonTapped(sender: AnyObject) {
        if scrollView.contentSize.width - view.frame.width != scrollView.contentOffset.x {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + view.frame.width, y: 0), animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource Methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListsCell")
        
        return cell!
    }
}