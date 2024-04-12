//
//  SoonTableViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/12/24.
//

import SnapKit
import UIKit

// CommingSoon 탭에서 테이블에서의 각 셀들을 구현한 Cell
class SoonTableViewCell: UITableViewCell {

    static let identifier = "SoonTableViewCell"
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 10
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Steamy . Soapy . Slow Burn . Suspenseful . Teen . Mystery"
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private let searchPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let remindButton = UIButton()
    private let shareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(searchPosterUIImageView)
        contentView.addSubview(posterLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(remindButton)
        contentView.addSubview(shareButton)
        
        setupButtons()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        config.imagePlacement = .top
        config.imagePadding = 5
        config.baseForegroundColor = .white
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 12)
        
        config.attributedTitle = AttributedString("Remind Me", attributes: titleContainer)
        config.image = UIImage(systemName: "bell.fill")
        remindButton.configuration = config

        config.attributedTitle = AttributedString("Share", attributes: titleContainer)
        config.image = UIImage(systemName: "square.and.arrow.up")
        shareButton.configuration = config
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        // 셀 내용에 패딩 적용
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)
    }
    
    private func setupConstraints() {
        searchPosterUIImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(searchPosterUIImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(0)
        }
        
        remindButton.snp.makeConstraints { make in
            make.top.equalTo(searchPosterUIImageView.snp.bottom).offset(10)
            make.trailing.equalTo(shareButton).offset(-60)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(shareButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    public func configure(with model: ComingSoonModel) {
        let imageName = model.imageName
        
        posterLabel.text = model.titleName
        descriptionLabel.text = model.description
        searchPosterUIImageView.image = UIImage(named: "\(imageName)")
    }
}
