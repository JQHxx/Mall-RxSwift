//
//  MessageViewController.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit
import RxDataSources

// MARK: - 消息列表
class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
 
    // MARK: - Lazy load
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    let disposeBag = DisposeBag()

}
