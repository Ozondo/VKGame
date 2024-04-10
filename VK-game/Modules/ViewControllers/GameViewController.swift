//
//  GameViewController.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import UIKit
//MARK: - extension CGFloat
private extension CGFloat {
    static let fifteen = 15.0
    static let twenty = 20.0
    static let thirtyFive = 35.0
    static let fifty = 50.0
    static let fiftyFive = 55.0
    static let sixty = 60.0
    static let seventy = 70.0
    static let oneHundred = 100.0
    static let twoGundredAndFifty = 250.0
    static let screenHeight = UIScreen.main.bounds.height
}

class GameViewController: UIViewController {
    //MARK: - properties
    var counterScore:Int = 0
    private var timer: Timer!
    var timerScore: Timer!
    var arr:[UserData] = []
    private var airplainX: NSLayoutConstraint?
    private var UFOX: NSLayoutConstraint?
    private var counter: CGFloat = 0
    private var displayLink: CADisplayLink?
    var userName = "User"
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    private var gameOverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gameOver")
        image.isHidden = true
        return image
    }()
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "tryAgain"), for: .normal)
        button.tag = 3
        button.isHidden = true
        button.addTarget(self, action: #selector(launchingTheGame), for: .touchUpInside)
        return button
    }()
    private lazy var backScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backScreen"), for: .normal)
        button.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
        return button
    }()
    private let leftShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreLeft")
        return image
    }()
    private let leftShoreSup: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreLeft")
        return image
    }()
    private let rightShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreRight")
        return image
    }()
    private let rightShoreSup: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreRight")
        return image
    }()
    private let airplaneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: .airplaneArr[UserSettings.modelAirplane ?? 0])
        return image
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(UIImage(named: "right"), for: .normal)
        button.addTarget(self, action: #selector(actionMoveAirplane), for: .touchUpInside)
        return button
    }()
    private lazy var shotButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(named: "shot"), for: .normal)
        button.addTarget(self, action: #selector(takeAShot), for: .touchUpInside)
        return button
    }()
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(named: "left"), for: .normal)
        button.addTarget(self, action: #selector(actionMoveAirplane), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsSuperview()
        setupViews()
        animationImage()
        createObstacle()
        scoring()
    }
    
    //MARK: - Func
    private func settingsSuperview() {
        view.layer.contents = UIImage(imageLiteralResourceName: "background").cgImage
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gameOverImage)
        gameOverImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tryAgainButton)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(airplaneImage)
        airplaneImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(shotButton)
        shotButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backScreenButton)
        backScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameOverImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameOverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameOverImage.heightAnchor.constraint(equalToConstant: .twoGundredAndFifty),
            gameOverImage.widthAnchor.constraint(equalToConstant: .twoGundredAndFifty),
            
            tryAgainButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: .screenHeight / 6),
            tryAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryAgainButton.widthAnchor.constraint(equalToConstant: .fifty),
            tryAgainButton.heightAnchor.constraint(equalToConstant: .fifty),
            
            backScreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .thirtyFive),
            backScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .thirtyFive),
            backScreenButton.widthAnchor.constraint(equalToConstant: .thirtyFive),
            backScreenButton.heightAnchor.constraint(equalToConstant: .thirtyFive),
            
            scoreLabel.topAnchor.constraint(equalTo: backScreenButton.bottomAnchor, constant: 10),
            scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .thirtyFive),
            scoreLabel.heightAnchor.constraint(equalToConstant: .fiftyFive),
            
            airplaneImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.oneHundred - .fifteen),
            airplaneImage.widthAnchor.constraint(equalToConstant: .fifty),
            airplaneImage.heightAnchor.constraint(equalToConstant: .fifty),
            
            shotButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.fiftyFive),
            shotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shotButton.widthAnchor.constraint(equalToConstant: .fifty),
            shotButton.heightAnchor.constraint(equalToConstant: .fifty),
            
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.fifty),
            leftButton.rightAnchor.constraint(equalTo: shotButton.leftAnchor, constant: -.twenty),
            leftButton.widthAnchor.constraint(equalToConstant: .seventy),
            leftButton.heightAnchor.constraint(equalToConstant: .sixty),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.fifty),
            rightButton.leftAnchor.constraint(equalTo: shotButton.rightAnchor, constant: .twenty),
            rightButton.widthAnchor.constraint(equalToConstant: .seventy),
            rightButton.heightAnchor.constraint(equalToConstant: .sixty)])
        
        airplainX = airplaneImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        airplainX?.isActive = true
    }
    
    private func animationImage() {
        view.addSubview(leftShore)
        leftShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightShore)
        rightShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftShoreSup)
        leftShoreSup.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightShoreSup)
        rightShoreSup.translatesAutoresizingMaskIntoConstraints = false
        
        let yConstraintLeftShore = leftShore.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -.screenHeight)
        yConstraintLeftShore.isActive = true
        
        let yConstraintRightShore = rightShore.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.screenHeight)
        yConstraintRightShore.isActive = true
        
        let yConstraintLeftShoreSup = leftShoreSup.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -.screenHeight)
        yConstraintLeftShoreSup.isActive = true
        
        let yConstraintRightShoreSup = rightShoreSup.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.screenHeight)
        yConstraintRightShoreSup.isActive = true
        
        NSLayoutConstraint.activate([
            leftShore.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftShore.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            rightShore.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightShore.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            leftShoreSup.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftShoreSup.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            rightShoreSup.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightShoreSup.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty)
        ])
        self.view.layoutIfNeeded()
        
        yConstraintLeftShore.constant = .screenHeight + .oneHundred
        yConstraintRightShore.constant = .screenHeight + .oneHundred
        
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            self.view.layoutIfNeeded()
        }
        
        yConstraintLeftShoreSup.constant = .screenHeight + .oneHundred
        yConstraintRightShoreSup.constant = .screenHeight + .oneHundred
        
        UIView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func createObstacle() {
        var speed: Double = 0
        if UserSettings.modeGame == 1 {
            speed = 3.5
        } else if UserSettings.modeGame == 0 {
            speed = 5
        } else if UserSettings.modeGame == 2 {
            speed = 2
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [ weak self ] timer in
            guard let self else { return }
            let image = UFOImageView(frame: .zero)
            
            self.view.insertSubview(image, at: 0)
            image.translatesAutoresizingMaskIntoConstraints = false
            
            let constant = CGFloat(Int.random(in: -150...150))
            let yConstraint = image.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.oneHundred)
            yConstraint.isActive = true
            
            NSLayoutConstraint.activate([
                image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: constant),
                image.heightAnchor.constraint(equalToConstant: .fifty),
                image.widthAnchor.constraint(equalToConstant: .fifty)
            ])
            self.view.layoutIfNeeded()
            
            yConstraint.constant = .screenHeight + .oneHundred
            
            UIView.animate(withDuration: speed, delay: 0, options: .curveLinear) {
                self.view.layoutIfNeeded()
            }
            self.startDisplayLink()
        }
    }
    
    //MARK: - Sup func
    private func scoring() {
        scoreLabel.isHidden = false
        scoreLabel.text = "Score: \(counterScore)"
        timerScore = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [weak self] timer in
            guard let self else { return }
            self.counterScore += 1
            self.scoreLabel.text = "Score: \(self.counterScore)"
        })
    }
    func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(checkForCollision))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    //MARK: - @objc func
    @objc func checkForCollision() {
        for subview in view.subviews {
            if subview is UFOImageView {
                guard let airplaneFrame = airplaneImage.layer.presentation()?.frame,
                      let UFOFrame = subview.layer.presentation()?.frame else { return }
                
                if airplaneFrame.intersects(UFOFrame) {
                    timer.invalidate()
                    timerScore.invalidate()
                    view.subviews.forEach{ $0.layer.removeAllAnimations() }
                    gameOverImage.isHidden = false
                    tryAgainButton.isHidden = false
                    leftButton.isEnabled = false
                    rightButton.isEnabled = false
                    shotButton.isEnabled = false
                }
            }
        }
        
        for cartridge in view.subviews {
            if cartridge is СartridgeImageView {
                guard let cartridgeFrame = cartridge.layer.presentation()?.frame else { return }
                for UFO in view.subviews {
                    if UFO is UFOImageView {
                        guard let UFOFrame = UFO.layer.presentation()?.frame else { return }
                        if cartridgeFrame.intersects(UFOFrame) {
                            UFO.removeFromSuperview()
                            cartridge.removeFromSuperview()
                            counterScore += Int(.fifteen)
                        }
                    }
                }
            }
        }
    }
    
    @objc func actionBackButton() {
        navigationController?.popViewController(animated: true)
        let recordVC = RecordViewController()
        let index = recordVC.userDataArray.count - 1
        if recordVC.userDataArray.isEmpty {
            let settingVC = SettingsViewController()
            guard let namePlayer = settingVC.nameLabel.text else { return }
            if namePlayer == "" {
                let user = UserData(name: "Anon", score: counterScore)
                recordVC.userDataArray.append(user)
            } else {
                let user = UserData(name: namePlayer, score: counterScore)
                recordVC.userDataArray.append(user)
            }
        } else {
            recordVC.userDataArray[index].score = counterScore
        }
    }
    
    @objc func actionMoveAirplane(sander: UIButton) {
        let screen = UIScreen.main.bounds.width
        if sander.tag == 0 {
            if counter < screen / 2 - .fiftyFive {
                counter += (screen / 4 - leftShore.bounds.width - 5)
            }
        }
        
        if sander.tag == 1 {
            if counter > -screen / 2 + .fiftyFive {
                counter -= (screen / 4 - leftShore.bounds.width - 5)
            }
        }
        
        self.airplainX?.constant = self.counter
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func takeAShot() {
        let cartridge = СartridgeImageView(frame: .zero)
        view.addSubview(cartridge)
        cartridge.translatesAutoresizingMaskIntoConstraints = false
        let yConstraintShot = cartridge.bottomAnchor.constraint(equalTo: airplaneImage.topAnchor)
        yConstraintShot.isActive = true
        let const = self.counter
        
        NSLayoutConstraint.activate([
            cartridge.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: const),
            cartridge.heightAnchor.constraint(equalToConstant: .twenty),
            cartridge.widthAnchor.constraint(equalToConstant: .twenty)])
        view.layoutIfNeeded()
        
        yConstraintShot.constant = -.screenHeight
        
        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func launchingTheGame() {
        for subview in view.subviews {
            if subview is UFOImageView {
                subview.removeFromSuperview()
            }
        }
        leftShoreSup.removeFromSuperview()
        leftShore.removeFromSuperview()
        rightShore.removeFromSuperview()
        rightShoreSup.removeFromSuperview()
        
        view.reloadInputViews()
        animationImage()
        createObstacle()
        scoring()
        scoreLabel.isHidden = true
        gameOverImage.isHidden = true
        tryAgainButton.isHidden = true
        leftButton.isEnabled = true
        rightButton.isEnabled = true
        shotButton.isEnabled = true
        counterScore = 0
    }
}

