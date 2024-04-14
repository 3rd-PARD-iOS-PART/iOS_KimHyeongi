//
//  SearchDetailViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/14/24.
//

import SnapKit
import UIKit

class SearchDetailViewController: UIViewController {
    var receivedModel: SearchViewModel?

    private let detailPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let buttonStackView = UIStackView()
    private var shareButton = UIButton()
    private var closeButton = UIButton()

    func setupPosterButton() {
        shareButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "shareplay"), for: .normal)
            button.tintColor = .white

            button.snp.makeConstraints { make in
                make.width.equalTo(35)
                make.height.equalTo(35)
            }

            return button
        }()

        closeButton = {
            let button = UIButton()

            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.tintColor = .white
            button.backgroundColor = .darkGray

            button.snp.makeConstraints { make in
                make.width.equalTo(35)
                make.height.equalTo(35)
            }

            button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)

            return button
        }()

        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.addArrangedSubview(closeButton)
        buttonStackView.spacing = 16
        buttonStackView.axis = .horizontal
    }

    @objc func tapCloseButton() {
        dismiss(animated: true)
    }

    private let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .light)
        let image = UIImage(systemName: "play.circle", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        detailPoster.image = UIImage(named: receivedModel?.detailName ?? "search_detail")
        detailPoster.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 210)
        view.addSubview(detailPoster)
        view.addSubview(buttonStackView)
        setupPosterButton()
        view.addSubview(playButton)

        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 코너 반지름 설정 (버튼의 너비나 높이의 절반으로 설정)
        shareButton.layer.cornerRadius = shareButton.frame.width / 2
        shareButton.backgroundColor = .darkGray
        shareButton.layer.masksToBounds = true

        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        closeButton.backgroundColor = .darkGray
        closeButton.layer.masksToBounds = true
    }

    private func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(detailPoster.snp.centerX)
            make.centerY.equalTo(detailPoster.snp.centerY).offset(20)
        }

    }
}
