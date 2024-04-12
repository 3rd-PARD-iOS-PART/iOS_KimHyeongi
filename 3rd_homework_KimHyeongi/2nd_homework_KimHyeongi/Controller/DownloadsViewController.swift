//
//  DownloadsViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/1/24.
//

import SnapKit
import UIKit

// 시간이 없어서 대충 했습니다.. 죄송합니다..
class DownloadsViewController: UIViewController {
    private let downloadIcon: UIImageView = {
        let image = UIImage(named: "download_icon", in: .none, with: UIImage.SymbolConfiguration(pointSize: 40))
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Movies and TV shows that you download appear here."
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        
        button.setTitle("Find Something to Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(downloadIcon)
        view.addSubview(mainLabel)
        view.addSubview(downloadButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        downloadIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(downloadIcon.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-150)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
}
