//
//  NoteViewController.swift
//  Note It
//
//  Created by James Parsons on 2/23/16.
//  Copyright © 2016 James Parsons. All rights reserved.
//

import UIKit
import Foundation

class NoteViewController: UIViewController {
    // MARK: - Properties
    var noteContent: String?
    var noteName: String?
    
    // MARK: - Outlets
    @IBOutlet weak var txtViewDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = noteName
        self.txtViewDetail.text = noteContent
    }
}
