//
//  Note.swift
//  Note It
//
//  Created by James Parsons on 2/19/16.
//  Copyright © 2016 James Parsons. All rights reserved.
//

import Foundation
import RealmSwift

// Realm model for notes.
class Note: Object {
    // MARK: - Properties
    dynamic var name = ""
    dynamic var content = ""
    dynamic var dateCreated = NSDate()
    
    // MARK: - Intializers
    required init() {
        super.init()
    }
    
    required init(name: String, content: String, date: NSDate) {
        self.name = name
        self.content = content
        self.dateCreated = date
        
        super.init()
    }

}