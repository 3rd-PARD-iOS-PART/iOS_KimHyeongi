//
//  DetailMemberViewController.swift
//  5th_homework_KimHyeongi
//
//  Created by 김현기 on 5/10/24.
//

import SnapKit
import Then
import UIKit

class DetailMemberViewController: UIViewController {
    weak var delegate: DetailMemberDelegate?

    var selectedMember: Member?

    lazy var deleteButton = UIButton().then {
        $0.setTitle("Delete", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.addTarget(self, action: #selector(deleteMember), for: .touchUpInside)
    }

    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }

    let ageLabel = UILabel()
    let partLabel = UILabel()

    @objc func deleteMember() {
        print("DELETE")

        let alertController = UIAlertController(
            title: "정말로 삭제하시겠습니까?",
            message: "삭제한 내용은 다시 되돌릴 수 없습니다.",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            if self.selectedMember != nil {
                guard let id = self.selectedMember?.id else { return }
                let urlString = "https://pard-host.onrender.com/pard/\(id)"

                guard let url = URL(string: urlString) else {
                    print("🚨 Invalid URL")
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"

                let task = URLSession.shared.dataTask(with: request) { _, response, error in
                    if let error = error {
                        print("🚨 Error : \(error.localizedDescription)")
                    } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        print("삭제 성공")
                        // 다시 getData()로 서버에 있는 데이터 불러오기
                        DispatchQueue.main.async {
                            self.delegate?.getData()
                        }
                    } else {
                        print("🚨 Error: No data returned or invalid response")
                    }
                }
                task.resume()
            } else {
                print("Selected Member is nil")
            }
            self.dismiss(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)

        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupLabels()

        addSubViews()
        setupConstraints()
    }

    func setupLabels() {
        nameLabel.text = selectedMember?.name
        ageLabel.text = "Age: \(String(selectedMember?.age ?? -1))"
        partLabel.text = "Part: \(selectedMember!.part)"
    }

    func addSubViews() {
        view.addSubview(deleteButton)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(partLabel)
    }

    func setupConstraints() {
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        partLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        ageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(partLabel.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(20)
        }
    }
}

protocol DetailMemberDelegate: AnyObject {
    func getData()
}
