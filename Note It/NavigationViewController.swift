//
//  NavigationViewController.swift
//  Note It
//
//  Created by James Parsons on 2/19/16.
//  Copyright © 2016 James Parsons. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the navigation bar.
        self.navigationBar.barTintColor = UIColor(red: 0.61, green: 0.35, blue: 0.71, alpha: 1.0)
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
