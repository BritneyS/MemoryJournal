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
    var selectedEntryIndex = 0
    
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
        
         print("EntryList at popEntryList: \(entryList)")
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

// MARK: UITableViewDelegate Protocol

extension EntryListTableViewController {
    //don't use didselect: will be one record behind
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedEntryIndex = indexPath.row
        print("Index: \(self.selectedEntryIndex)")
        return indexPath
    }
}

// MARK: Segue

extension EntryListTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Entry: \(self.entryList[selectedEntryIndex])")
        print("Segue triggered")
        if segue.identifier == Identity.entryDetailsSegue.rawValue {
            guard let entryDetailsViewController = segue.destination as? EntryDetailsViewController else { print("No object")
                return }
            print("EntryList: \(entryList)")
            entryDetailsViewController.entryData = entryList[selectedEntryIndex]
            print("Entry: \(entryList[selectedEntryIndex])")
//            entryDetailsViewController.delegate = self
//        } else if segue.identifier == SegueIdentifier.addContactSegueIdentifier.rawValue {
//            guard let addContactViewController = segue.destination as? AddContactViewController else { return }
//            addContactViewController.delegate = self  // self is ContactListViewController here, assigning this class as delegate
//        }
        }
    }
}

