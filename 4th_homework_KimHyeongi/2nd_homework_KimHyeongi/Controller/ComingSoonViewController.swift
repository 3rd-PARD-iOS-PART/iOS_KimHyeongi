//
//  ComingSoonViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/1/24.
//

import SnapKit
import UIKit

class ComingSoonViewController: UIViewController {
    // 상단 노티 파트
    private let appIconStackView = UIStackView()

    func setupNotification() {
        let logoIcon: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "bell.circle.fill")
            imageView.tintColor = .red

            return imageView
        }()

        let appName: UILabel = {
            let label = UILabel()

            label.text = "Notification"
            label.textColor = .white
            label.font = .systemFont(ofSize: 20, weight: .bold)

            return label
        }()

        appIconStackView.addArrangedSubview(logoIcon)
        appIconStackView.addArrangedSubview(appName)
        appIconStackView.spacing = 10
        appIconStackView.axis = .horizontal
        appIconStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(20)
        }
    }

    // 커밍순 테이블 파트
    private let commingSoonTable: UITableView = {
        let table = UITableView()
        table.register(SoonTableViewCell.self, forCellReuseIdentifier: SoonTableViewCell.identifier)

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(appIconStackView)
        view.addSubview(commingSoonTable)
        setupNotification()

        commingSoonTable.delegate = self
        commingSoonTable.dataSource = self

        setupConstraints()
    }

    // 스냅킷을 사용한 위치 배치
    private func setupConstraints() {

        commingSoonTable.snp.makeConstraints { make in
            make.top.equalTo(appIconStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension ComingSoonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comingSoonMockData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SoonTableViewCell.identifier, for: indexPath) as? SoonTableViewCell

        let data = comingSoonMockData[indexPath.row]
        cell?.configure(with: ComingSoonModel(titleName: data.titleName, description: data.description, imageName: data.imageName))

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }
}
