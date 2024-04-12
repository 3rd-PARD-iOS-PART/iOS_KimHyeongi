//
//  SearchViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/1/24.
//

import SnapKit
import UIKit

class SearchViewController: UIViewController {
    
    // 서치바 부분에서 좀 더 디벨롭 하고 싶었으나 개인 역량 미흡으로 인해 더 매끄럽게 하지 못했습니다. 죄송합니다..
    private let searchController = UISearchController()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Searches"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search for a show, movie, genre, e.t.c. "
        
        view.addSubview(searchController.searchBar)
        view.addSubview(mainLabel)
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupConstraints() {
        searchController.searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
        }
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(150)
        }
        searchTable.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
        
        let data = mockData[indexPath.row]
        cell?.configure(with: SearchViewModel(titleName: data.titleName, imageName: data.imageName))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
