//
//  SearchDetailViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/14/24.
//

import SnapKit
import Then
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

    private let component1 = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .gray
        config.buttonSize = .mini
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 8)
        var attrTitle = AttributedString("S E R I E S")
        attrTitle.font = .system(size: 10, weight: .bold)
        config.attributedTitle = attrTitle
        var confImage = UIImage(named: "logo_netflix")
        config.image = confImage
        config.imagePlacement = .leading
        config.imagePadding = 10
        $0.contentMode = .scaleAspectFit

        $0.configuration = config
    }

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }

    private let component2 = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "search_detail_bar")
    }

    private let component3 = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        config.background.backgroundColor = .white
        config.buttonSize = .medium
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        var attrTitle = AttributedString("Play")
        attrTitle.font = .system(size: 16, weight: .bold)
        config.attributedTitle = attrTitle
        var confImage = UIImage(systemName: "play.fill")
        config.image = confImage
        config.imagePlacement = .leading
        config.imagePadding = 10
        $0.configuration = config
    }

    private let component4 = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .gray
        config.baseBackgroundColor = .darkGray
        config.buttonSize = .medium
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        var attrTitle = AttributedString("Download")
        attrTitle.font = .system(size: 16, weight: .bold)
        config.attributedTitle = attrTitle
        var confImage = UIImage(systemName: "arrow.down.to.line")
        config.image = confImage
        config.imagePlacement = .leading
        config.imagePadding = 10

        $0.configuration = config
    }

    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 0
    }

    private let subDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let buttonComponent = UIStackView().then {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 10
        config.imagePlacement = .top
        config.baseForegroundColor = .white

        var attrTitle = AttributedString("My List")

        config.image = UIImage(systemName: "plus")
        config.attributedTitle = attrTitle
        let addButton = UIButton(configuration: config)

        attrTitle = AttributedString("Rate")
        config.image = UIImage(systemName: "hand.thumbsup")
        config.attributedTitle = attrTitle
        let rateButton = UIButton(configuration: config)

        attrTitle = AttributedString("Share")
        config.image = UIImage(systemName: "paperplane")
        config.attributedTitle = attrTitle
        let shareButton = UIButton(configuration: config)

        $0.addArrangedSubview(addButton)
        $0.addArrangedSubview(rateButton)
        $0.addArrangedSubview(shareButton)
        $0.axis = .horizontal
        $0.spacing = 20
    }

    private let categoryTitleList = ["Episodes", "Collection", "More Like This", "Trailers & More"]

    private lazy var pagingTabBar = PagingTabBar(categoryTitleList: categoryTitleList)
    private lazy var pagingView = PagingView(categoryTitleList: categoryTitleList, pagingTabBar: pagingTabBar)

    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
    }

    private let contentView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupComponents()

        addSubViews()

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
}

private extension SearchDetailViewController {
    private func addSubViews() {
        detailPoster.image = UIImage(named: receivedModel?.detailName ?? "detail_image")
        detailPoster.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 250)
        view.addSubview(detailPoster)
        view.addSubview(buttonStackView)
        setupPosterButton()
        view.addSubview(playButton)

        scrollView.addSubview(contentView)
        // ScrollView
        view.addSubview(scrollView)
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
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(detailPoster.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(scrollView)
        }
    }

    private func setupComponents() {
        // Component1
        contentView.addArrangedSubview(component1)
        component1.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }

        // TitleLabel
        contentView.addArrangedSubview(titleLabel)
        titleLabel.text = receivedModel?.titleName
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }

        // Component2
        contentView.addArrangedSubview(component2)
        component2.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(200)
        }

        // Component3
        contentView.addArrangedSubview(component3)
        component3.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }

        // Component4
        contentView.addArrangedSubview(component4)
        component4.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }

        // subTitleLabel
        subTitleLabel.text = receivedModel?.subTitleName
        contentView.addArrangedSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }

        // subDescriptionLabel
        subDescriptionLabel.text = receivedModel?.description
        contentView.addArrangedSubview(subDescriptionLabel)
        subDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }

        // ButtonComponent
        contentView.addArrangedSubview(buttonComponent)
        buttonComponent.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(100)
        }

        // PagingTabBar
        contentView.addArrangedSubview(pagingTabBar)
        pagingTabBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(pagingTabBar.cellHeight)
        }

        // PagingView
        contentView.addArrangedSubview(pagingView)
        pagingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(pagingTabBar.snp.bottom)
        }

        // 추가하고 싶은 다른 컴포넌트들을 여기에 추가
    }
}
