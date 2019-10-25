//
//  TableViewTest1VC.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

// MARK: - 使用自带的Section
class TableViewTest1VC: UIViewController {

    // 创建数据源
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: {(dataSource, tableView, indexPath, element) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                  cell.textLabel?.text = "\(indexPath.row)：\(element)"
                  return cell
    })
    
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
        
        tableView.rx.setDelegate(self)
        .disposed(by: disposeBag)
        
        // 模型点击事件
        tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self](str) in
            guard let `self` = self else { return }
            debugPrint(str)
            debugPrint(self)
            
        }).disposed(by: disposeBag)
        
        // indexPath 点击
        tableView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
             guard let `self` = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            debugPrint(indexPath)
        }).disposed(by: disposeBag)
        
        //绑定单元格数据
         items
             .bind(to: tableView.rx.items(dataSource: dataSource))
             .disposed(by: disposeBag)
    }
 
    // MARK: - Lazy load
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    //初始化数据 （使用自带的SectionModel）
    lazy var items = Observable.just([
        SectionModel(model: "", items: [
            "UILable的用法",
            "UIText的用法",
            "UIButton的用法"
            ])
        ])
    let disposeBag = DisposeBag()

}

extension TableViewTest1VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        debugPrint(str)
        return 200
    }
}
