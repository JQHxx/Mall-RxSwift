//
//  HomeViewController.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var vmOutput: HomeViewModel.HomeOutput? = nil
    let homeViewModel = HomeViewModel()
    var requestRelay = BehaviorRelay<HomeRequest>.init(value: HomeRequest())

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    func bindView() {
        /*
        let request = HomeRequest()
        let requestRelay: BehaviorRelay<HomeRequest> = BehaviorRelay<HomeRequest>.init(value: request)
         */
        let vmInput = HomeViewModel.HomeInput(request: requestRelay)
        vmOutput = homeViewModel.transform(input: vmInput)
        
        vmOutput?.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh: break
            case .endHeaderRefresh: break
            case .beingFooterRefresh: break
            case .endFooterRefresh: break
            case .noMoreData: break
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        
        /*
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vmOutput.requestCommand.onNext(true)
        })
        
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vmOutput.requestCommand.onNext(false)
        })
         */
    }

}
