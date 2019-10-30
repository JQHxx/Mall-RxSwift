//
//  MessageViewModel.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit


class MessageViewModel: NSObject {
    var messageModels = BehaviorRelay<[MessageData]>(value: [])
    var pageIndex: Int = 0
}

extension MessageViewModel: PViewModelType {

    typealias PInput = Input
    typealias POutput = Output
    
    struct Input {
        var request: BehaviorRelay<MessageRequest>
        init(request: BehaviorRelay<MessageRequest>) {
            self.request = request
        }
    }
    
    struct Output {
        let refreshStatus = BehaviorRelay<SRefreshStatus>(value: .none)
        let requestCommand = PublishSubject<Bool>()
        var datas: Driver<[MessageData]>
        init(datas: Driver<[MessageData]>) {
            self.datas = datas
        }
    }
    
    func transform(input: MessageViewModel.Input) -> MessageViewModel.Output {
        let datas = messageModels.asObservable().map{ (models) -> [MessageData] in
            return models
        }.asDriver(onErrorJustReturn: [])

        let output = Output(datas: datas)
        
        input.request.asObservable().subscribe {
            let request = $0.element
            
            output.requestCommand.subscribe( onNext: { [weak self] isReloadData in
                guard let `self` = self else { return }
                // self.pageIndex = isReloadData ? 0 : self.pageIndex + 1
                MoyaNetwork.shared.requestDataWithTargetString(target: CommonAPI.commonRequest(r: request!))
                    .asObservable()
                    .subscribe {[weak self] event in
                        guard let `self` = self else { return }
                        switch event {
                        case let .next(result):
                            let model = MessageModel.init(JSON.init(result))
                            self.messageModels.accept(isReloadData ? model.datas : (self.messageModels.value) + model.datas)
                            Toast.default.showSuccess("加载成功")
                        case let .error(error):
                            Toast.default.showError(error.localizedDescription)
                        case .completed:
                            output.refreshStatus.accept(isReloadData ? SRefreshStatus.endHeaderRefresh : SRefreshStatus.endFooterRefresh)
                        }
                }.disposed(by: self.rx.disposeBag)
                
            }).disposed(by: self.rx.disposeBag)
            
        }.disposed(by: rx.disposeBag)
        
        return output
    }
    
}
