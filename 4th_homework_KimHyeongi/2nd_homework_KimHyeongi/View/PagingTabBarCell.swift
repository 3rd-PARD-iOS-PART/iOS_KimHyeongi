//
//  PagingTabBarCollectionViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 5/1/24.
//

import SnapKit
import UIKit

class PagingTabBarCell: UICollectionViewCell {
    static let identifier = "PagingTabBarCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var upperLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPink
        view.alpha = 0.0
        
        return view
    }()
    
    override var isSelected: Bool {
        // Cell이 선택 되었을 때 설정
        didSet {
            titleLabel.font = isSelected ? .systemFont(ofSize: 12, weight: .bold) : .systemFont(ofSize: 12)
            upperLine.alpha = isSelected ? 1.0 : 0.0
        }
    }
    
    func setupView(title: String) {
        setupLayout()
        titleLabel.text = title
    }
}

private extension PagingTabBarCell {
    func setupLayout() {
        [
            upperLine,
            titleLabel
        ].forEach { addSubview($0) }
        upperLine.snp.makeConstraints { make in
            make.height.equalTo(3.0)
            make.leading.trailing.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(upperLine.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
}
