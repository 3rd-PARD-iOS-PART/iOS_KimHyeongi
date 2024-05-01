//
//  PagingCollectionViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 5/1/24.
//

import SnapKit
import UIKit

class PagingCollectionViewCell: UICollectionViewCell {
    static let identifier = "PagingCollectionViewCell"

    private lazy var episodeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: frame.width, height: 120) // Example size
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

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

private extension PagingCollectionViewCell {
    func addSubViews() {
        contentView.addSubview(episodeCollectionView)
    }

    func setupConstraints() {
        episodeCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PagingCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 해당 데이터 배열 크기 반환. 예시로 10을 사용
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
            fatalError("Unable to dequeue EpisodeCollectionViewCell")
        }
        // Episode 데이터 설정, 예시로 단순히 설정 생략
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PagingCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 적절한 cell 크기 설정, cell 내용에 따라 조절할 수 있음
        return CGSize(width: collectionView.frame.width, height: 200) // 예시 크기
    }
}
