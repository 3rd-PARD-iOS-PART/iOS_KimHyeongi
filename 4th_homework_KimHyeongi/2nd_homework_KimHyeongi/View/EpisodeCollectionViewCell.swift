//
//  EpisodeCollectionViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 5/2/24.
//

import SnapKit
import Then
import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeCollectionViewCell"

    private let videoPlayer = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "video_player")
    }

    private let episodeTitle = UILabel().then {
        $0.text = "0. Episode Name"
    }

    private let runningTime = UILabel().then {
        $0.text = "37m"
        $0.textColor = .gray
    }

    private let episodeDescription = UILabel().then {
        $0.text = "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return."
        $0.numberOfLines = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black

        addSubViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EpisodeCollectionViewCell {
    func addSubViews() {
        contentView.addSubview(videoPlayer)
        contentView.addSubview(episodeTitle)
        contentView.addSubview(runningTime)
        contentView.addSubview(episodeDescription)
    }

    func setupConstraints() {
        videoPlayer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }

        episodeTitle.snp.makeConstraints { make in
            make.leading.equalTo(videoPlayer.snp.trailing).offset(20)
            make.centerY.equalTo(videoPlayer).offset(-10)
        }

        runningTime.snp.makeConstraints { make in
            make.leading.equalTo(videoPlayer.snp.trailing).offset(20)
            make.top.equalTo(episodeTitle.snp.bottom).offset(10)
        }

        episodeDescription.snp.makeConstraints { make in
            make.top.equalTo(videoPlayer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
    }
}
