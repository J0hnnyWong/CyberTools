//
//  JNWNumerationTranferViewController.swift
//  CyberTools
//
//  Created by John on 2021/3/12.
//

import UIKit

class JNWNumerationTranferViewController: UIViewController {
    
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
    
    lazy var numerationTypePicker: UIPickerView = {
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func render() {
        view.backgroundColor = .white
        
        view.addSubview(fromTextField)
        view.addSubview(toTextField)
        view.addSubview(numerationTypePicker)
        
        fromTextField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.height.equalTo(30)
        }
        
        toTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fromTextField.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.height.equalTo(30)
        }
        
        numerationTypePicker.snp.makeConstraints { (make) in
            make.top.equalTo(toTextField.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.height.equalTo(160)
        }
    }

    func transfor() {
        
        NumerationTranfer.transfer(value: fromTextField.text ?? "", from: .binary, to: .decimal)
    }
}

extension JNWNumerationTranferViewController: UIPickerViewDelegate {
    
}

extension JNWNumerationTranferViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
}
