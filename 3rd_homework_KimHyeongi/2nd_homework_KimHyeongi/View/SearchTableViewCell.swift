//
//  SearchTableViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/12/24.
//

import SnapKit
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let playButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        button.setImage(icon, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let searchPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .darkGray
        
        contentView.addSubview(searchPosterUIImageView)
        contentView.addSubview(posterLabel)
        contentView.addSubview(playButton)
        
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        // 셀 내용에 패딩 적용
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)
    }
    
    private func setupConstraints() {
        searchPosterUIImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(100)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        posterLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchPosterUIImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    public func configure(with model: SearchViewModel) {
        let imageName = model.imageName
        
        posterLabel.text = model.titleName
        searchPosterUIImageView.image = UIImage(named: "\(imageName)")
    }
}
