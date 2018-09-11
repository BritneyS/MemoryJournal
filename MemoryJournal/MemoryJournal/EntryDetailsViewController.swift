//
//  EntryDetailsViewController.swift
//  MemoryJournal
//
//  Created by Britney Smith on 9/10/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: Properties
    var entryData: JournalEntry?
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entry data on viewDidLoad: \(self.entryData?.title) \(self.entryData?.date) \(self.entryData?.content)")
        resetView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Implementation
    
    func resetView() {
        guard let entryData = self.entryData else { print ("No data")
            print("Entry data on resetView: \(self.entryData?.title) \(self.entryData?.date) \(self.entryData?.content)")
            return }
        print("Entry data on resetView: \(entryData.title) \(entryData.date) \(entryData.content)")
        populateData(data: entryData)
    }
    
    func populateData(data: JournalEntry) {
        journalTitleLabel.text = entryData?.title
        dateLabel.text = data.date
        contentLabel.text = data.content
        print("Entry data on populateData: \(data.title) \(data.date) \(data.content)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
