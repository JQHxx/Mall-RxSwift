//
//  HomeViewModel.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    var homeModel = BehaviorRelay<HomeModel>(value: HomeModel(JSON.null))
    var pageIndex: Int = 0
}

extension HomeViewModel: PViewModelType {

    typealias PInput = Input
    typealias POutput = Output
    
    struct Input {
        var request: BehaviorRelay<HomeRequest>
        init(request: BehaviorRelay<HomeRequest>) {
            self.request = request
        }
    }
    
    struct Output {
        let refreshStatus = BehaviorRelay<SRefreshStatus>(value: .none)
        let requestCommand = PublishSubject<Bool>()
        var homeModel: Driver<HomeModel>
        init(model: Driver<HomeModel>) {
            self.homeModel = model
        }
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {

        let output = Output(model: homeModel.asObservable().asDriver(onErrorJustReturn: HomeModel(JSON.null)))
        
        input.request.asObservable().subscribe {
            let request = $0.element
            
            output.requestCommand.subscribe( onNext: { [unowned self] isReloadData in
                self.pageIndex = isReloadData ? 0 : self.pageIndex + 1
                MoyaNetwork.shared.requestDataWithTargetString(target: CommonAPI.commonRequest(r: request!))
                    .asObservable()
                    .subscribe {[weak self] event in
                        switch event {
                        case let .next(result):
                            //                             self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                            self?.homeModel.accept(HomeModel(JSON.init(result)))
                            TProgressHUD.showSuccess("加载成功")
                        case let .error(error):
                            TProgressHUD.showError(error.localizedDescription)
                        case .completed:
                            output.refreshStatus.accept(isReloadData ? SRefreshStatus.endHeaderRefresh : SRefreshStatus.endFooterRefresh)
                        }
                }.disposed(by: self.rx.disposeBag)
                
            }).disposed(by: self.rx.disposeBag)
            
        }.disposed(by: rx.disposeBag)
        

        return output
    }
    
}
