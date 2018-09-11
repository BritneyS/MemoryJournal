//
//  EntryDetailsViewController.swift
//  MemoryJournal
//
//  Created by Britney Smith on 9/10/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

protocol EntryDetailsViewControllerDelegate: class {
    func entryDetailsViewControllerDidCancel(_ controller: EntryDetailsViewController)
    func entryDetailsViewControllerEdit(_ controller: EntryDetailsViewController, didFinishEdit item: JournalEntry)
}

class EntryDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    // MARK: Properties
    var entryData: JournalEntry?
    weak var delegate: EntryDetailsViewControllerDelegate?
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Implementation
    
    func resetView() {
        guard let entryData = self.entryData else {
            print ("No data")
            return
        }
        populateData(data: entryData)
        toggleTextFields()
    }
    
    func populateData(data: JournalEntry) {
        journalTitleLabel.text = entryData?.title
        dateLabel.text = data.date
        contentLabel.text = data.content
    }
    
    func toggleTitleText() {
        if navigationItem.title == "Entry Details" {
            navigationItem.title = "Edit Entry"
        } else {
            navigationItem.title = "Entry Details"
        }
    }

    func toggleTextFields() {
        titleTextField.isHidden = !titleTextField.isHidden
        dateTextField.isHidden = !dateTextField.isHidden
        contentTextView.isHidden = !contentTextView.isHidden
    }
    
    func toggleButtonTitle () {
        if editButton.currentTitle == TitleText.editEntry.rawValue {
            editButton.setTitle(TitleText.cancelEdit.rawValue, for: .normal)
        } else {
            editButton.setTitle(TitleText.editEntry.rawValue, for: .normal)
        }
    }
    
    // MARK: Actions
    
    @IBAction func edit(_ sender: UIButton) {
        toggleTitleText()
        toggleTextFields()
        toggleButtonTitle()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let entry = entryData else { return }
        guard let updatedTitle = titleTextField.text else { return }
        guard let updatedDate = dateTextField.text else { return }
        guard let updatedContent = contentTextView.text else { return }
        
        entry.title = updatedTitle
        entry.date = updatedDate
        entry.content = updatedContent
        
        delegate?.entryDetailsViewControllerEdit(self, didFinishEdit: entry)
    }
    
    
}
