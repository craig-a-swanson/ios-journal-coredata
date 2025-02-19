//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Craig Swanson on 12/3/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // The entryController and entry will be passed from the EntriesTableViewController
    var entryController: EntryController?
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodytextTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    @IBAction func saveJournalEntry(_ sender: UIBarButtonItem) {
        // title must have a value or the save will not continue.
        // bodytext is allowed to be empty.
        guard let title = titleTextField.text,
            !title.isEmpty else { return }
        let bodytext = bodytextTextField.text ?? ""
        
        // if an existing entry was passed from the tableview, the updates are saved
        if let entry = entry {
            entry.title = title
            entry.bodyText = bodytext
            entryController?.updateEntry(for: entry)
            navigationController?.popViewController(animated: true)
        } else {
            // if it is a new entry, an new Entry object is creted and saved to the array.
            let entry = Entry(title: title, bodyText: bodytext, timestamp: Date())
            entryController?.createEntry(for: entry)
            navigationController?.popViewController(animated: true)
        }
    }
    
    // If an existing entry is passed from the tableview, it sets the UI items to the correct values.
    private func updateViews() {
        guard isViewLoaded else { return }
        
        title = entry?.title ?? "Create Entry"
        titleTextField.text = entry?.title
        bodytextTextField.text = entry?.bodyText
    }
    
}
