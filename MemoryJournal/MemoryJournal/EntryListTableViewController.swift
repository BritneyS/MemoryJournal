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
            let newEntry = JournalEntry(title: entry.title, content: entry.content, date: entry.date)
            entryList.append(newEntry)
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
        switch segue.identifier {
        case Identity.entryDetailsSegue.rawValue:
            print("entryDetails segue")
            guard let entryDetailsViewController = segue.destination as? EntryDetailsViewController else {
                print("No object")
                return
            }
            entryDetailsViewController.entryData = entryList[selectedEntryIndex]
            entryDetailsViewController.delegate = self
        case Identity.addEntrySegue.rawValue:
            print("addEntry segue")
            guard let addEntryTableViewController = segue.destination as? AddEntryTableViewController else {
                print("No object")
                return
            }
            addEntryTableViewController.delegate = self
        default:
            print("Something's wrong")
        }
    }
}

// MARK: AddEntryTableViewControllerDelegate Protocol Implementation

extension EntryListTableViewController: AddEntryTableViewControllerDelegate {
    func addEntryTableViewControllerDidCancel(_ controller: AddEntryTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addEntryTableViewControllerAdd(_ controller: AddEntryTableViewController, didFinishAdding item: JournalEntry) {
        
        let newRowIndex = entryList.count
        entryList.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: EntryDetailsViewControllerDelegate Protocol Implementation

extension EntryListTableViewController: EntryDetailsViewControllerDelegate {
    func entryDetailsViewControllerDidCancel(_ controller: EntryDetailsViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func entryDetailsViewControllerEdit(_ controller: EntryDetailsViewController, didFinishEdit item: JournalEntry) {
        guard let index = entryList.index(of: item) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.textLabel?.text = item.titleAndDate
        navigationController?.popViewController(animated: true)
    }
    
    
}


