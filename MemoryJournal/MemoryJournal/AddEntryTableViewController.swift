//
//  AddEntryTableViewController.swift
//  MemoryJournal
//
//  Created by Britney Smith on 9/11/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class AddEntryTableViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        var frame = self.contentTextView.frame
        frame.size.height = 75
        self.contentTextView.frame = frame
    }
    
    // MARK: Custom Row Height
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 100.0
        } else {
            return 50.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        
    }
    
    


}
