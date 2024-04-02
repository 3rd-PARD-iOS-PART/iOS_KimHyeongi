//
//  HomeViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/1/24.
//

import SnapKit
import UIKit

enum Sections: Int {
    case PopularMovies = 0
    case TrendingMovies = 1
    case Temp1 = 2
    case Temp2 = 3
    case Temp3 = 4
    case Temp4 = 5
}

class HomeViewController: UIViewController {
    
    private var logoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logo_netflix"), for: .normal)
        return button
    }()
    
    private let navButton1: UIButton = {
        let button = UIButton()
        button.setTitle("TV Shows", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let navButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let navButton3: UIButton = {
        let button = UIButton()
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoButton, navButton1, navButton2, navButton3])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    }()
    
    private var isStackViewHidden = false
    
    private let sectionTitles: [String] = [
        "Popular on Netflix",
        "Trending Now",
        "Top 10 in Korea Today",
        "My List",
        "African Movies",
        "Hollywood Movies & TV"
    ]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        view.addSubview(stackView)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        setupConstraints()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    /*
     UIView의 Layout : 화면에서 UIView의 크기와 위치를 정의
     모든 View는 frame을 가지고, 부모뷰에서 어디에 위치하고 얼마나 크기를 차지하는가를 나타낸다.
     
     viewWillLayoutSubviews() -> layoutSubviews() -> viewDidLayoutSubviews()
     
     viewDidLayoutSubviews()
     - View가 SubView들의 배치를 조정하고 난 직후에 하고 싶은 작업들이 있다면 override
     -> 다른 뷰들 컨텐트 업데이트
     -> 뷰들 크기, 위치 최종 조정
     -> 테이블 데이터 reload
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.top.equalToSuperview().offset(70)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath)
            as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.PopularMovies.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Temp1.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Temp2.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Temp3.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Temp4.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY > 0 && !isStackViewHidden {
            isStackViewHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.alpha = 0
            })
        } else if offsetY <= 0 && isStackViewHidden {
            isStackViewHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.alpha = 1
            })
        }
    }
}
