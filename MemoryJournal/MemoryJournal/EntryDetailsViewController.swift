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
    }
    
    func populateData(data: JournalEntry) {
        journalTitleLabel.text = entryData?.title
        dateLabel.text = data.date
        contentLabel.text = data.content
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
