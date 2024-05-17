//
//  AddUserViewController.swift
//  5th_homework_KimHyeongi
//
//  Created by 김현기 on 5/10/24.
//

import SnapKit
import Then
import UIKit

class AddMemberViewController: UIViewController {
    weak var delegate: AddMemberDelegate?
    
    private let pardURL = "https://pard-host.onrender.com/pard"
    
    let titleLabel = UILabel().then {
        $0.text = "Pard 멤버 추가"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    let nameTextField = UITextField().then {
        $0.placeholder = "이름을 입력하세요"
        $0.keyboardType = .default
        $0.backgroundColor = .black
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        $0.leftViewMode = .always
        // 쓸데 없는 경고문 출력 제거
        $0.autocorrectionType = .no
    }
    
    let ageTextField = UITextField().then {
        $0.placeholder = "나이를 입력하세요"
        $0.keyboardType = .numberPad
        $0.backgroundColor = .black
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        $0.leftViewMode = .always
        // 쓸데 없는 경고문 출력 제거
        $0.autocorrectionType = .no
    }
    
    let partTextField = UITextField().then {
        $0.placeholder = "파트를 입력하세요"
        $0.keyboardType = .default
        $0.backgroundColor = .black
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        $0.leftViewMode = .always
        // 쓸데 없는 경고문 출력 제거
        $0.autocorrectionType = .no
    }
    
    lazy var addButton = UIButton().then {
        $0.setTitle("추가하기", for: .normal)
        $0.addTarget(self, action: #selector(addUser), for: .touchUpInside)
    }
    
    @objc func addUser() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "🚨", message: "이름을 입력하세요.")
            return
        }
        guard let age = ageTextField.text, !age.isEmpty else {
            showAlert(title: "🚨", message: "나이를 입력하세요.")
            return
        }
        guard let part = partTextField.text, !part.isEmpty else {
            showAlert(title: "🚨", message: "파트를 입력하세요.")
            return
        }
        let newMember = Member(
            name: nameTextField.text!,
            part: partTextField.text!,
            age: Int(ageTextField.text!)!
        )
        
        guard let url = URL(string: pardURL) else {
            print("INVALID URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encoder = JSONEncoder()
            let JSONData = try encoder.encode(newMember)
            request.httpBody = JSONData
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("🚨", error)
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                        DispatchQueue.main.async {
                            self.delegate?.getData(part: .All)
                        }
                    }
                }
            }
            task.resume()
        } catch {
            print("🚨", error)
        }
        
        delegate?.gotoAll()
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTextFields()
        
        addSubViews()
        setupConstraints()
    }
    
    func setupTextFields() {
        nameTextField.delegate = self
        ageTextField.delegate = self
        partTextField.delegate = self
    }
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(ageTextField)
        view.addSubview(partTextField)
        view.addSubview(addButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        partTextField.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension AddMemberViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        } else if textField == ageTextField {
            partTextField.becomeFirstResponder()
        }
        return true
    }
}

protocol AddMemberDelegate: AnyObject {
    func getData(part: Category)
    func gotoAll()
}
