//
//  ListVC.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation
import UIKit


class ListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: - Private methods
    private func bind() {
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    // MARK: - Setter & Getter
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "ListViewCell")
        return tableView
    }()
}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
