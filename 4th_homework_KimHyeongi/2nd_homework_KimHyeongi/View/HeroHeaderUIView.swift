//
//  HeroHeaderUIView.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/2/24.
//

import SnapKit
import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()

    private let playButton = UIButton()
    private let myListButton = UIButton()
    private let infoButton = UIButton()

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()

        setupButtons()

        addSubViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }

    private func setupButtons() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.baseBackgroundColor = .lightGray
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 10
//        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.baseForegroundColor = .black

        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedTitle = AttributedString("Play", attributes: titleContainer)
        playButton.configuration = config

        config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "plus")
        config.imagePlacement = .top
        config.imagePadding = 5
        config.title = "My List"
        config.baseForegroundColor = .white
        myListButton.configuration = config

        config.image = UIImage(systemName: "info.circle")
        config.title = "Info"
        infoButton.configuration = config
    }

    private func addSubViews() {
        addSubview(playButton)
        addSubview(infoButton)
        addSubview(myListButton)
    }

    private func setupConstraints() {
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(110)
        }

        myListButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalTo(playButton).offset(-120)
        }

        infoButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalTo(playButton).offset(120)
        }
    }
}
