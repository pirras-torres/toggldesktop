//
//  EditorViewController.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 3/21/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

final class EditorViewController: NSViewController {

    // MARK: OUTLET

    @IBOutlet weak var projectBox: NSBox!
    @IBOutlet weak var projectTextField: ProjectAutoCompleteTextField!

    // MARK: Variables

    var timeEntry: TimeEntryViewItem! {
        didSet {
            projectTextField.setTimeEntry(timeEntry)
        }
    }
    private var selectedProjectItem: ProjectContentItem? {
        didSet {
            projectTextField.stringValue = selectedProjectItem?.name ?? ""
        }
    }
    private lazy var projectDatasource = ProjectDataSource(items: ProjectStorage.shared.items,
                                                           updateNotificationName: .ProjectStorageChangedNotification)

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        initDatasource()
    }
    
    @IBAction func closeBtnOnTap(_ sender: Any) {
        
    }
}

// MARK: Private

extension EditorViewController {

    fileprivate func initCommon() {
        view.wantsLayer = true
        view.layer?.masksToBounds = false
    }

    fileprivate func initDatasource() {
        projectDatasource.delegate = self
        projectDatasource.setup(with: projectTextField)
    }
}

// MARK: AutoCompleteViewDataSourceDelegate

extension EditorViewController: AutoCompleteViewDataSourceDelegate {

    func autoCompleteSelectionDidChange(sender: AutoCompleteViewDataSource, item: Any) {
        if sender == projectDatasource {
            if let projectItem = item as? ProjectContentItem {
                selectedProjectItem = projectItem
                projectTextField.closeSuggestion()
            }
        }
    }
}
