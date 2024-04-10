//
//  ViewController.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import UIKit

//MARK: - extension
extension CGFloat {
    static let leftOffset = 70.0
    static let rightoffset = -70.0
}

extension String {
    static let startString = "Start"
    static let settingsString = "Settings"
    static let recordsString = "Records"
}

class MenuViewController: UIViewController {
    //MARK: - property
    private let stackView = UIStackView()
    private let startButton = UIButton()
    private let settingsButton = UIButton()
    private let recordButton = UIButton()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupButtons()
    }
   
    //MARK: - Flow func
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .leftOffset),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: .rightoffset)])
    }
    
    private func setupButtons() {
        let buttons = [startButton, settingsButton, recordButton]
        buttons.forEach{
            stackView.addArrangedSubview($0)
            $0.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.setTitleColor( .darkText, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 21)
            $0.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        }
        startButton.setTitle(.startString, for: .normal)
        startButton.tag = 0

        settingsButton.setTitle(.settingsString, for: .normal)
        settingsButton.tag = 1

        recordButton.setTitle(.recordsString, for: .normal)
        recordButton.tag = 2

    }
    
    @objc func actionButton(sender: UIButton) {
        if sender.tag == 0 {
            let gameVC = GameViewController()
            navigationController?.pushViewController(gameVC, animated: true)

        }
        if sender.tag == 1 {
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)

        }
        if sender.tag == 2 {
            let recordsViewController = RecordViewController()
            navigationController?.pushViewController(recordsViewController, animated: true)

        }
    }
}

