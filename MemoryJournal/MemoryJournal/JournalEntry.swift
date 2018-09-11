//
//  JournalEntry.swift
//  MemoryJournal
//
//  Created by Britney Smith on 9/10/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
//Journal entries should have a title, content, and a date
class JournalEntry: NSObject {
    var title: String
    var content: String
    var date: String
    
    init(title: String, content: String, date: String) {
        self.title = title
        self.content = content
        self.date = date
    }
    
    var titleAndDate: String {
        return "\(title) - \(date)"
    }
    
}
