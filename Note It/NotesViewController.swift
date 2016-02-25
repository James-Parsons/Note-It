//
//  NotesViewController.swift
//  Note It
//
//  Created by James Parsons on 2/19/16.
//  Copyright © 2016 James Parsons. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class NotesViewController: UITableViewController {
    // MARK: - Properties
    var notes: Results<Note>?
    var realm: Realm?
    // Notification token
    var token: NotificationToken?
    var selectedNoteRow: Int?

    // MARK: ViewController methods.
    override func viewDidLoad() {
        
        // Refresh the table.
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })

        // Set up our Realm.
        realm = try! Realm()
        
        // Get all the notes.
        notes = realm!.objects(Note)
        
        token = notes!.addNotificationBlock({ (notification, realm) -> Void in
            self.tableView.reloadData()
        })
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of objects.
        return realm!.objects(Note).count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("note", forIndexPath: indexPath)
        
        // Set up the cell with our data
        if let note = notes?[indexPath.row] {
            cell.textLabel?.text = note.name
            cell.detailTextLabel?.text = dateToString(note.dateCreated)
        }
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedNoteRow = indexPath.row
        
        self.performSegueWithIdentifier("noteDetail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "noteDetail") {
            let controller = segue.destinationViewController as! NoteViewController
            
            let note = self.notes![self.selectedNoteRow!]
            
            controller.noteName = note.name
            controller.noteContent = note.content
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Deinitializer
    deinit {
        if let t = token {
            t.stop()
        }
    }
    
    // MARK: - Functions
    func dateToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        
        return formatter.stringFromDate(date)
        
    }

}
