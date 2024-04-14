//
//  CollectionViewTableViewCell.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/2/24.
//
/*
 MARK: View는...
 - 주입된 데이터만을 노출 할 수 있으며, Preview를 통해 독단적인 화면 확인도 가능합니다.
 - 누가 자신을 쓰는지 모릅니다. 의존성과는 관련 없는 단순 무식한 영역입니다.
 */

import UIKit

// UITableViewCell은 기본적으로 SubView frame을 직접 설정해주지 않음.
class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"

    private var movies: [Movie] = .init()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 180)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     collectionView을 contentView에 추가했지만, layoutSubviews() 메서드에서 프레임을 설정하지 않았기 때문에
     컬렉션 뷰의 프레임이 자동으로 계산되지 않았다.
     따라서 컬렉션 뷰는 contentView의 영역 밖에 배치되어 화면에 표시되지 않았다.
     */
    override func layoutSubviews() {
        super.layoutSubviews()

        // contentView의 영역 전체를 collectionView의 프레임으로 설정
        collectionView.frame = contentView.bounds
    }

    public func configure(with movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }

        guard let model = movies[indexPath.row].poster_path else { return UICollectionViewCell() }

        cell.configure(with: model)

        return cell
    }

}
