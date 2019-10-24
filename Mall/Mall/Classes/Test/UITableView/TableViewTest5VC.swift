//
//  TableViewTest5VC.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit


class TableViewTest5VC: UIViewController {

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
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                //初始化cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                cell?.textLabel?.text = "\(element)"
                 
                /*
                //cell中按钮点击事件订阅
                cell.button.rx.tap.asDriver()
                    .drive(onNext: { [weak self] in
                        self?.showAlert(title: "\(row)", message: element)
                    }).disposed(by: cell.disposeBag)
                */
                 
                return cell!
            }.disposed(by: disposeBag)
    }
 
    // MARK: - Lazy load
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
             //初始化数据
       let items = Observable.just([
           "文本输入框的用法",
           "开关按钮的用法",
           "进度条的用法",
           "文本标签的用法",
           ])

    let disposeBag = DisposeBag()

}
