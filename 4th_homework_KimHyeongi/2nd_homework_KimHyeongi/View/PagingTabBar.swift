//
//  PagingTabBar.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 5/1/24.
//

import SnapKit
import UIKit

protocol PagingDelegate: AnyObject {
    func didTapPagingTabBarCell(scrollTo indexPath: IndexPath)
}

class PagingTabBar: UIView {
    var cellHeight: CGFloat { 44.0 }
    
    private var categoryTitleList: [String]
    
    weak var delegate: PagingDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // scrollDirection의 기본값은 .vertical이다
        
        // 각 탭 아이템 간격 정의
        let space: CGFloat = 5 // 여기서는 예시로 각 아이템 사이의 간격을 10으로 설정
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
            
//        // 섹션 인셋 정의
//        let totalSpacing = space * (CGFloat(categoryTitleList.count) - 1) // 총 간격
//        let availableWidth = UIScreen.main.bounds.width - layout.sectionInset.left - layout.sectionInset.right - totalSpacing - 20
//        let widthPerItem = availableWidth / CGFloat(categoryTitleList.count)
            
        // collection view 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PagingTabBarCell.self, forCellWithReuseIdentifier: PagingTabBarCell.identifier)
        
        return collectionView
    }()
    
    init(categoryTitleList: [String]) {
        self.categoryTitleList = categoryTitleList
        super.init(frame: .zero)
        setupLayout()
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: []) // 처음에 첫 탭에 포커싱
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PagingTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapPagingTabBarCell(scrollTo: indexPath)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.systemFont(ofSize: 12) // 실제 탭 타이틀에 사용하는 글꼴로 조정하세요.
        let text = categoryTitleList[indexPath.row]
        
        // 탭 타이틀에 따른 적절한 셀 너비 추정
        let textSize = NSString(string: text).size(withAttributes: [NSAttributedString.Key.font: font])
        
        // 셀 너비는 텍스트 너비에 좌우 여백 추가하기
        let cellWidth = textSize.width + 18 // 텍스트 양 옆에 여백을 줍니다. 여백은 실제 디자인에 맞게 조정해야 합니다.
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension PagingTabBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitleList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagingTabBarCell.identifier, for: indexPath) as? PagingTabBarCell else { return UICollectionViewCell() }
        
        cell.setupView(title: categoryTitleList[indexPath.row])
        
        return cell
    }
}

private extension PagingTabBar {
    func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
