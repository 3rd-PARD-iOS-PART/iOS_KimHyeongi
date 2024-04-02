//
//  DownloadsViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/1/24.
//

import SnapKit
import UIKit

class DownloadsViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Downloads뷰 입니다!"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
