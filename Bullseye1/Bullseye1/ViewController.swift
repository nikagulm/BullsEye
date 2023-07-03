//
//  ViewController.swift
//  Bullseye1
//
//  Created by Nika Gulmamadova on 6/21/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var GuessingLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var RoundLabel: UILabel!
    let gameManager = GameManager()
    
 
    @IBOutlet weak var HitMeButton: UIImageView!
    @IBOutlet weak var hitMeFrame: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesLabel.text = rulesLabel.text?.uppercased()
        
        let thumbImage = UIImage(named: "nube")
        slider.setThumbImage(thumbImage, for: .normal)
        
        HitMeButton.layer.cornerRadius = 21
        HitMeButton.layer.borderWidth = 3
        HitMeButton.layer.borderColor = UIColor.white.cgColor
        
        
        
        //             UI VIEW
        
        
//        let tagGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        hitMeFrame.addGestureRecognizer(tagGesture)
        

    // UI view
       // view.backgroundColor = .darkGray
        
        
        updateLabels()
        
    }
    
//    @objc func handleTap() {
//        print ("i was tapped")
//    }
    
    
    
    
    
    @IBOutlet weak var rulesLabel: UILabel!
    
    @IBAction func handleButtonTap(_ sender: Any) {
        
        
        // guessed number - 100
        // approximately - 50
        // example 65
        // 55..<65 = 50
        // 66...75 - 50
        
        // 65 - 45 = 20
        // 65 - 87 = -22
        
        let selectedNumber = Int(slider.value)
        if  selectedNumber == gameManager.guessingNumber {
            print ("Вы угадали число")
            gameManager.score += 100 //gameManager.score = gameManager.score + 100
        } else if abs(gameManager.guessingNumber - selectedNumber) <= 10 {
            gameManager.score += 50
        }
        
        if gameManager.round < 10 {
            gameManager.nextRound()
        } else {
            let myAlert = UIAlertController(title: "Game over", message: "Вы заработали \(gameManager.score) очков. Начать новую игру? ", preferredStyle: .actionSheet)
            
            let handler: ((UIAlertAction) -> Void)? = { action in
                print ("Стартуем новую игру")
                self.updateLabels()
                self.gameManager.startNewGame()
            
            }
            let action = UIAlertAction(title: "Начать", style: .default, handler: handler)
            myAlert.addAction(action)
            
            let cancelAction = UIAlertAction(title: "Закончить игру?", style: .cancel)
            myAlert.addAction(cancelAction)
            
            show(myAlert, sender: self)
        }
        

        updateLabels()
    }
    
    func updateLabels() {
        GuessingLabel.text = String (gameManager.guessingNumber)
        RoundLabel.text = String (gameManager.round)
        ScoreLabel.text = String (gameManager.score)
    }
}


