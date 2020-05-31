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
    private let stickyHeaderView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "header"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.stickyHeader.view = stickyHeaderView
        tableView.stickyHeader.height = 300
        tableView.stickyHeader.minimumHeight = 100
        tableView.stickyHeader.maskColor = UIColor.black.withAlphaComponent(0.7)
        tableView.stickyHeader.delegate = self
        
        tableView.stickyHeader.didMaskViewAlphaChange = { alpha in
            print("didMaskViewAlphaChange closure: \(alpha)")
        }
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

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FTDelegate
extension ViewController: FTDelegate {
    
    func didMaskViewAlphaChange(alpha: CGFloat) {
        print("didMaskViewAlphaChange delegate: \(alpha)")
    }
}
