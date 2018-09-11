//
//  EntryListTableViewController.swift
//  MemoryJournal
//
//  Created by Britney Smith on 9/10/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK: Properties
    
    var entryList: [JournalEntry] = []
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateEntryList()
        useLargeTitles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
// MARK: Private Implementation

extension EntryListTableViewController {
    
    private func populateEntryList() {
        let journalEntries = Entries()
        
        for entry in journalEntries.entries {
            let newEntry = JournalEntry(title: entry.title, content: entry.title, date: entry.date)
            entryList.append(newEntry)
            print("\(newEntry.title), \(newEntry.content), \(newEntry.date)")
        }
    }
    
    private func swipeToDelete(indexPath: IndexPath) {
        entryList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    private func useLargeTitles() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: UITableViewDataSource Protocol

extension EntryListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identity.journalEntry.rawValue, for: indexPath)
        cell.textLabel?.text = entryList[indexPath.row].titleAndDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            swipeToDelete(indexPath: indexPath)
        }
    }
}
