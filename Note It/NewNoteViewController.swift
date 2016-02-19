//
//  ViewController.swift
//  Note It
//
//  Created by James Parsons on 2/19/16.
//  Copyright © 2016 James Parsons. All rights reserved.
//

import UIKit
import CoreData

class NewNoteViewController: UIViewController {
    // MARK: - Properties
    var save: Bool?
    
    // MARK: - Outlets
    @IBOutlet weak var txtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up insets.
        txtView.contentInset = UIEdgeInsetsMake(-50, 10, 0, 0)
        
        // Do we have any data from the last time?
        let data: String? = NSUserDefaults.standardUserDefaults().objectForKey("lastNoteData") as? String
        
        if (data != nil) {
            txtView.text = data
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Do we want to save the data?
        if save! {
            if txtView.hasText() {
                // Save the current note data
                let noteData = txtView.text
                NSUserDefaults.standardUserDefaults().setValue(noteData, forKey: "lastNoteData")
            }
        } else {
            // No need to save note data. Clear the setting.
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "lastNoteData")
        }
        
    }

    // MARK: - Actions
    @IBAction func btnCancel(sender: UIBarButtonItem) {
        // Save note content
        save = true
        self.navigationController!.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func btnSave(sender: UIBarButtonItem) {
        var alert: UIAlertController
        
        if txtView.hasText() {
            let textToSerialize = txtView.text
            
            alert = UIAlertController(title: "Save", message: "Enter a name for this note", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action: UIAlertAction) -> Void in
                // Don't serialize data.
                self.save = false
                
                // Go back.
                self.navigationController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alert.addTextFieldWithConfigurationHandler {
                (textField: UITextField) -> Void in
            }
            
            alert.addAction(cancelAction)
            alert.addAction(saveAction)
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            // Notes cannot be blank.
            let alert = UIAlertController(title: "Whoops", message: "This note needs some content", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(okAction)
            
            // Show the alert.
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
}

