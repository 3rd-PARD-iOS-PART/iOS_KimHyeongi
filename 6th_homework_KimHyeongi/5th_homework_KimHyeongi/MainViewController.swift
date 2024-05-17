//
//  ViewController.swift
//  5th_homework_KimHyeongi
//
//  Created by 김현기 on 5/9/24.
//

import SnapKit
import Then
import UIKit

enum Category {
    case All
    case Web
    case iOS
    case Server
}

class MainViewController: UIViewController {
    private let pardURL = "https://pard-host.onrender.com/pard"

    let category = ["All", "Web", "iOS", "Server"]

    lazy var segmentedControl = UISegmentedControl(items: category)

    lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    let titleLabel = UILabel().then {
        $0.text = "URL SESSION"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }

    lazy var addButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "추가"
        $0.configuration = config
        $0.addTarget(self, action: #selector(openAddModal), for: .touchUpInside)
    }

    var data: [Member] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged(to:)), for: .valueChanged)

        addSubViews()
        setupConstraints()

        getData(part: .All)
    }
}

// MARK: Main 관련 메소드

extension MainViewController {
    @objc func indexChanged(to sender: UISegmentedControl) {
        print("\(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        case 0:
            getData(part: .All)
        case 1:
            getData(part: .Web)
        case 2:
            getData(part: .iOS)
        case 3:
            getData(part: .Server)
        default:
            getData(part: .All)
        }
    }

    @objc func openAddModal() {
        let addMemberVC = AddMemberViewController()
        addMemberVC.delegate = self

        let nav = UINavigationController(rootViewController: addMemberVC)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }

        present(nav, animated: true, completion: nil)
    }

    func openDetailModal(selectedMember: Member) {
        let detailMemberVC = DetailMemberViewController()
        detailMemberVC.delegate = self
        detailMemberVC.selectedMember = selectedMember

        let nav = UINavigationController(rootViewController: detailMemberVC)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }

        present(nav, animated: true, completion: nil)
    }

    func addSubViews() {
        view.addSubview(segmentedControl)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
    }
}

// MARK: tableView 관련 Delegate

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "[\(data[indexPath.row].part)]\t\(data[indexPath.row].name)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = data[indexPath.row]

        openDetailModal(selectedMember: member)
    }
}

// MARK: AddMemberVC Delegate

extension MainViewController: AddMemberDelegate, DetailMemberDelegate {
    func gotoAll() {
        segmentedControl.selectedSegmentIndex = 0
    }

    func getData(part: Category) {
        print("GET DATA...")
        var url = pardURL
        switch part {
        case .All:
            break
        case .iOS:
            url = "\(pardURL)?part=iOS"
        case .Web:
            url = "\(pardURL)?part=Web"
        case .Server:
            url = "\(pardURL)?part=server"
        }
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error!)
                    return
                }
                // Get JSON Data
                if let JSONData = data {
                    let dataString = String(data: JSONData, encoding: .utf8)
                    print(dataString!)
                    // JSON Decoder 사용
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode([Member].self, from: JSONData)
                        self.data = decodeData

                        // Main Thread에서 Reload해야 보임.
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print("🚨", error)
                    }
                }
            }
            task.resume()
        }
    }
}
