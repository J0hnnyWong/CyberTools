//
//  JNWCyberToolsMenuViewController.swift
//  CyberTools
//
//  Created by John on 2021/3/12.
//

import UIKit
import SnapKit

class JNWCyberToolsMenuViewController: UIViewController {
    
    lazy var numerationTransferButton: UIButton = {
        let button = UIButton()
        button.setTitle("Numeration Transfer", for: .normal)
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        render()
        events()
    }
    
    func render() {
        view.backgroundColor = .white
        
        view.addSubview(numerationTransferButton)
        numerationTransferButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    func events() {
        numerationTransferButton.addTarget(self, action: #selector(jumpToNumeration), for: .touchUpInside)
    }
    
    @objc
    func jumpToNumeration() {
        let numerationPage = JNWNumerationTranferViewController()
        navigationController?.pushViewController(numerationPage, animated: true)
    }

}
