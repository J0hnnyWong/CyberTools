//
//  JNWNumerationTranferViewController.swift
//  CyberTools
//
//  Created by John on 2021/3/12.
//

import UIKit
import RxSwift

class JNWNumerationTranferViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = JNWNumerationTranferViewModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var fromTypeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("from", for: .normal)
        return button
    }()
    
    lazy var toTypeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("to", for: .normal)
        return button
    }()
    
    lazy var fromTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var toTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        events()
    }
    
    func render() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(bgView)
        
        bgView.addSubview(stackView)
        
        [fromTypeButton, fromTextField, toTypeButton, toTextField]
        .forEach({ stackView.addArrangedSubview($0) })
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(bgView.safeAreaLayoutGuide.snp.right).offset(-16)
            make.top.equalTo(bgView.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(bgView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        fromTypeButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        
        toTypeButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        
        fromTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        
        toTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
    }
    
    func events() {
        
        fromTypeButton.addTarget(self, action: #selector(fromButtonAction), for: .touchUpInside)
        toTypeButton.addTarget(self, action: #selector(toButtonAction), for: .touchUpInside)
        
        viewModel.fromType.subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: disposeBag)
        
        viewModel.fromType.subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: disposeBag)
        
        viewModel.fromType.subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: disposeBag)
    }
    
    @objc
    func fromButtonAction() {
        showNumerationTypeListMenu(title: "type", message: "from") { (num) in
            print(num)
        }
    }
    
    @objc
    func toButtonAction() {
        showNumerationTypeListMenu(title: "type", message: "to") { (num) in
            print(num)
        }
    }
    
    func showNumerationTypeListMenu(title: String?, message: String?, handler: ((numeration) -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        numeration.all
        .map { (num) -> UIAlertAction in
            UIAlertAction(title: num.description(), style: .default) { (action) in
                handler?(num)
            }
        }
        .forEach { (action) in
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: JNWLocalizedString(key: "cancel"), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func transfor() {
        
        NumerationTranfer.transfer(value: fromTextField.text ?? "", from: .binary, to: .decimal)
    }
}
