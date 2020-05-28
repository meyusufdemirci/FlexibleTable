//
//  ViewController.swift
//  FlexibleTable
//
//  Created by Yusuf Demirci on 05/28/2020.
//  Copyright (c) 2020 Yusuf Demirci. All rights reserved.
//

import UIKit
import FlexibleTable

class ViewController: UIViewController {

    // MARK: - UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let stickyHeaderView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.stickyHeader.view = stickyHeaderView
        tableView.stickyHeader.height = 300
        tableView.stickyHeader.minimumHeight = 100
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}
