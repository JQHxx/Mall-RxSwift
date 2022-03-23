//
//  LoginVC.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import UIKit

let countDownSeconds: Int = 60

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    deinit {
        debugPrint("deinit")
    }
    
    // MARK: - Private methods
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(self.accoutTextField)
        view.addSubview(self.passwordTextField)
        //view.addSubview(self.codeTextField)
        //view.addSubview(self.codeButton)
        view.addSubview(self.loginButton)
        
        self.accoutTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.height.equalTo(40)
        }
        
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.accoutTextField.snp_bottom).offset(15)
            make.left.equalTo(self.accoutTextField)
            make.right.equalTo(self.accoutTextField)
            make.height.equalTo(40)
        }
        
        /*
        self.codeTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp_bottom).offset(15)
            make.left.equalTo(self.accoutTextField)
            make.height.equalTo(40)
        }
        
        self.codeButton.snp.makeConstraints { make in
            make.left.equalTo(self.codeTextField.snp_right).offset(5)
            make.top.bottom.equalTo(self.codeTextField)
            make.right.equalTo(self.accoutTextField)
            //make.width.lessThanOrEqualTo(80)
        }
        self.codeButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        self.codeTextField.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
         */

        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp_bottom).offset(15)
            make.left.equalTo(self.accoutTextField)
            make.right.equalTo(self.accoutTextField)
            make.height.equalTo(40)
        }
    }
    

    func bind() {
        
        let input = LoginViewModel.Input.init(account: self.accoutTextField.rx.text.orEmpty.asDriver(), password: self.passwordTextField.rx.text.orEmpty.asDriver(), loginTap:loginButton.rx.tap.asDriver())
        vmOutput = vm.transform(input: input)
        
        vmOutput?.usernameUsable.asObservable().bind(to: loginButton.rx.isEnabled).disposed(by: rx.disposeBag)
        
        vmOutput?.usernameUsable.asObservable().subscribe(onNext: { [weak self](relut) in
            guard let `self` = self else { return }
            debugPrint(self)
            debugPrint(relut)
            self.loginButton.backgroundColor = relut ? UIColor.orange : UIColor.gray
            
        }).disposed(by: rx.disposeBag)
        
        self.loginButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            debugPrint(self)
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)

        
        /*
        //按钮点击响应
        self.loginButton.rx.tap
         .throttle(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                debugPrint(self)
                //self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)

        // warning: - 怎么立即销毁定时任务
        // 获取验证码倒计时
        let timer = Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
           .map{countDownSeconds - $0}
           .filter{ $0 >= 0 }
           .asDriver(onErrorJustReturn: 0)
        
        
        let second = codeButton.rx.tap
            .flatMapLatest { _ -> Driver<Int> in
                return timer
        }
        let sendCodeButtonText = second.map { $0 == 0 ? " 发送验证码 ":" 再次发送(\($0)s) "}
        let sendButtonEnable = second.map{$0 == 0 ? true : false}
        
        sendCodeButtonText
            .bind(to: codeButton.rx.title(for: .normal))
            .disposed(by: rx.disposeBag)
        
        sendButtonEnable
            .bind(to: codeButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
         */
    }
    
    // MARK: - Setter & Getter
    private lazy var accoutTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.lightGray
        textField.placeholder = "请输入账号"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.lightGray
        textField.placeholder = "请输入密码"
        return textField
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.lightGray
        textField.placeholder = "请输入验证码"
        return textField
    }()
    
    private lazy var codeButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle(" 获取验证码 ", for: UIControl.State.normal)
        button.backgroundColor = UIColor.orange
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("登录", for: UIControl.State.normal)
        button.backgroundColor = UIColor.orange
        return button
    }()
    
    var vm: LoginViewModel = LoginViewModel()
    var vmOutput: LoginViewModel.Output?
}
