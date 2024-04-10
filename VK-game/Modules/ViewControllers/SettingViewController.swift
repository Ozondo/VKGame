//
//  SettingViewController.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import UIKit

//MARK: - extension
private extension String {
    static let speedArray = ["Slow", "Normal", "Fast"]
    static let aletMassege = "Укажите новое имя"
    static let alertPlaceholder = "Ну давай, удиви меня"
    static let alertButton = ["Отмена", "Изменить"]
}
private extension CGFloat {
    static let stackViewTop = 120.0
    static let stackViewHeightAnchor = 70.0
    static let stackViewWidthAnchor = 250.0
    static let foutyOffset = 40.0
    static let backScreenButtonLeftAnchor = 5.0
    static let backScreenButtonWithAndHeight = 35.0
    static let oneHundredOffset = 100.0
    static let fiftyOffset = 50.0
    static let seventyOffset = 70.0
    static let minusSpeedButtonWithAndHeight = 60.0
    static let thirtyOffset = 30.0
    static let fifeOffset = 5.0
    static let oneHundredSeventyOffset = 170.0
    static let sixtyFifeOffset = 65.0
}

class SettingsViewController: UIViewController {
    //MARK: - property
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "forward"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.text = UserSettings.userName
        label.textColor = .black
        return label
    }()
    private lazy var backScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backScreen"), for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(returnToPreviousScreen), for: .touchUpInside)
        return button
    }()
    private lazy var writeName: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "writeName"), for: .normal)
        button.addTarget(self, action: #selector(actionWriteNameButton), for: .touchUpInside)
        
        return button
    }()
    private lazy var minusSpeedButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.addTarget(self, action: #selector(actionSpeedButton), for: .touchUpInside)
        return button
    }()
    private lazy var plusSpeedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(actionSpeedButton), for: .touchUpInside)
        return button
    }()
    private let speedNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textColor = .black
        return label
    }()
    let userDefaults = UserDefaults()
    private var airplaneImage = UIImageView()
    private let stackView = UIStackView()
    private var counter = UserSettings.modelAirplane ?? 1
    var speedCounter = UserSettings.modeGame ?? 1
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupViews()
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Flow func
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 35
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let subView = [backwardButton,airplaneImage,forwardButton]
        subView.forEach{
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: .stackViewTop),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: .stackViewHeightAnchor),
            stackView.widthAnchor.constraint(equalToConstant: .stackViewWidthAnchor)])
    }
    
    private func setupViews() {
        view.addSubview(backScreenButton)
        backScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(writeName)
        writeName.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(minusSpeedButton)
        minusSpeedButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(plusSpeedButton)
        plusSpeedButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(speedNameLabel)
        speedNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backScreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .foutyOffset),
            backScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .backScreenButtonLeftAnchor),
            backScreenButton.widthAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            backScreenButton.heightAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -.oneHundredOffset),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .oneHundredOffset),
            nameLabel.heightAnchor.constraint(equalToConstant: .foutyOffset),
            
            writeName.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: .fifeOffset),
            writeName.heightAnchor.constraint(equalToConstant: .thirtyOffset),
            writeName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -.sixtyFifeOffset),
            writeName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
            minusSpeedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -.seventyOffset),
            minusSpeedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.oneHundredOffset),
            minusSpeedButton.heightAnchor.constraint(equalToConstant: .minusSpeedButtonWithAndHeight),
            minusSpeedButton.widthAnchor.constraint(equalToConstant: .minusSpeedButtonWithAndHeight),
        
            plusSpeedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: .seventyOffset),
            plusSpeedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.oneHundredOffset),
            plusSpeedButton.heightAnchor.constraint(equalToConstant: .fiftyOffset),
            plusSpeedButton.widthAnchor.constraint(equalToConstant: .fiftyOffset),
        
            speedNameLabel.bottomAnchor.constraint(equalTo: minusSpeedButton.topAnchor, constant: -.thirtyOffset),
            speedNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedNameLabel.widthAnchor.constraint(equalToConstant: .oneHundredSeventyOffset),
            speedNameLabel.heightAnchor.constraint(equalToConstant: .fiftyOffset)])
        
        airplaneImage.image = UIImage(named: .airplaneArr[counter])
        speedNameLabel.text = .speedArray[speedCounter]
    }
    
    @objc func actionButton(sender: UIButton) {
        if sender.tag == 1 {
            if counter < 3 {
                counter += 1
            } else {
                counter = 0
            }
        }
        if sender.tag == 0 {
            if counter > 0 {
                counter -= 1
            }else {
                counter = 3
            }
        }
        UserSettings.modelAirplane = counter
        airplaneImage.image = UIImage(named: .airplaneArr[counter])
    }
    
    @objc private func returnToPreviousScreen() {
            navigationController?.popViewController(animated: true)
        }
        
    @objc func actionWriteNameButton() {
        let alert = UIAlertController(title: nil, message: .aletMassege, preferredStyle: .alert)
        alert.addTextField { text in
            text.placeholder = .alertPlaceholder
        }
        
        alert.addAction(UIAlertAction(title: .alertButton[0], style: .default))
        alert.addAction(UIAlertAction(title: .alertButton[1], style: .cancel) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            UserSettings.userName = text
            self.nameLabel.text = UserSettings.userName
            let user = UserData(name: "\(text)", score: 0)
            let recordVC = RecordViewController()
            recordVC.userDataArray.append(user)
        })
        self.present(alert, animated: true)
    }
    
    @objc func actionSpeedButton(sender: UIButton) {
        if sender.tag == 0 {
            if speedCounter > 0 {
                speedCounter -= 1
                print(speedCounter)
            }
        }
            if sender.tag == 1 {
                if speedCounter < 2 {
                    speedCounter += 1
                    print(speedCounter)

                }
            }
        UserSettings.modeGame = speedCounter
        speedNameLabel.text = .speedArray[speedCounter]

        }
    }


