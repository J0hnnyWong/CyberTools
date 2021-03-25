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
        tf.placeholder = "from"
        tf.delegate = self
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var toTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "to"
        tf.delegate = self
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
        fromTextField.addTarget(self, action: #selector(textFieldEditing(sender:)), for: .editingChanged)
        
        
        viewModel.fromTypeDidSet.append { [weak self] (nume) in
            guard let sself = self else { return }
            sself.fromTypeButton.setTitle("\(nume)", for: .normal)
        }
        
        viewModel.toTypeDidSet.append { [weak self] (nume) in
            guard let sself = self else { return }
            sself.toTypeButton.setTitle("\(nume)", for: .normal)
        }
        
        viewModel.toNumStrDidSet.append { [weak self] (result) in
            guard let sself = self else { return }
            sself.toTextField.text = result
        }
    }
    
    @objc
    func fromButtonAction() {
        showNumerationTypeListMenu(title: "type", message: "from") { [weak self] (num) in
            guard let sself = self else { return }
            sself.viewModel.fromType = num
        }
    }
    
    @objc
    func toButtonAction() {
        showNumerationTypeListMenu(title: "type", message: "to") { [weak self] (num) in
            guard let sself = self else { return }
            sself.viewModel.toType = num
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
}

extension JNWNumerationTranferViewController: UITextFieldDelegate {
    
    @objc
    func textFieldEditing(sender: UITextField) {
        if sender == fromTextField {
            viewModel.fromNumStr = sender.text
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == fromTextField {
            viewModel.fromNumStr = textField.text
        } //else if textField == toTextField {
//            viewModel.toNumStr = textField.text
//        }
    }
}
