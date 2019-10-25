//
//  CollectionViewTest1VC.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class CollectionViewTest1VC: UIViewController {
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>!
    
    /*
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>.init(configureCell: { (datasource, collectionView, indexPath, item) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
            cell.label.text = "\(item)"
            return cell
    }, configureSupplementaryView: {(ds ,cv, kind, ip) in
        let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                    withReuseIdentifier: "Section", for: ip) as! MySectionHeader
        section.label.text = "\(ds[ip.section].model)"
        return section
    })
    */

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>.init(configureCell: { (datasource, collectionView, indexPath, item) in
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
            cell.label.text = "\(item)"

            // button 的点击事件
            cell.button.rx.tap.asDriver().drive(onNext: {

            }).disposed(by: cell.disposeBag)


            cell.button.rx.tap.subscribe(onNext: { recognizer in

            }).disposed(by: cell.disposeBag)
            
            // 防止多次点击
            cell.button.rx.tap.asObservable().debounce(1, scheduler: MainScheduler.instance).subscribe(onNext: {
            }).disposed(by: cell.disposeBag)

            cell.button.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { recognizer in

            }).disposed(by: cell.disposeBag)
            
            
            // 手势点击
            /*
            let tap = UITapGestureRecognizer()
            cell.label.addGestureRecognizer(tap)
            cell.label.isUserInteractionEnabled = true
            tap.rx.event.subscribe(onNext: { [weak self] recognizer in
                guard let `self` = self else { return }
                debugPrint(self)
                debugPrint("手势点击")
            }).disposed(by: cell.disposeBag)
             */
            cell.label.rx.tapAction.subscribe(onNext: { [weak self] recognizer in
                guard let `self` = self else { return }
                debugPrint(self)
                debugPrint("手势点击")
            }).disposed(by: cell.disposeBag)
            
            return cell
        })
        
        // collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        dataSource.configureSupplementaryView = {(ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                        withReuseIdentifier: "Section", for: ip) as! MySectionHeader
            section.label.text = "\(ds[ip.section].model)"
            return section
        }
        //绑定单元格数据
         items
             .bind(to: collectionView.rx.items(dataSource: dataSource))
             .disposed(by: disposeBag)
    }
    
    // MARK: - Lazy load
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        //创建一个重用的单元格
        collectionView.register(MyCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    //初始化数据
    let items = Observable.just([
        SectionModel(model: "", items: [
            "Swift",
            "PHP",
            "Python",
            "Java",
            "javascript",
            "C#"
            ])
        ])
    
    let disposeBag = DisposeBag()

}
