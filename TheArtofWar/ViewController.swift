//
//  ViewController.swift
//  TheArtofWar
//
//  Created by CSOM on 4/27/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    
    let cardNames = ["card2",
                     "card3",
                     "card4",
                     "card5",
                     "card6",
                     "card7",
                     "card8",
                     "card9",
                     "card10",
                     "jack",
                     "queen",
                     "king",
                     "ace"]
    
    var rightScore = 0
    var leftScore = 0
    var cardFlip = AVAudioPlayer()
    var aboutButton: UIButton!
    var aboutButtonSize: CGSize!
  //  var resetButton: UIButton!
  //  var resetButtonSize: CGSize!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureAboutButton()
       // configureResetButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound() {
        let soundName = "sound0"
        
        if let sound = NSDataAsset(name: soundName) {
            do {
                try cardFlip = AVAudioPlayer(data: sound.data)
                cardFlip.play()
            } catch {
                print("Error: Data from \(soundName) could not be played as an audio file")
            }
        } else {
            print("Error: Could not load data from file \(soundName)")
        }
    }
    
    func configureAboutButton() {
        let aboutButtonText = "About"
        let aboutButtonFont = UIFont.systemFont(ofSize: 15)
        let fontAttributes = [NSFontAttributeName: aboutButtonFont]
        aboutButtonSize = aboutButtonText.size(attributes: fontAttributes)
        
        aboutButtonSize.height += 16
        aboutButtonSize.width = aboutButtonSize.width + 16
        
        aboutButton = UIButton(frame: CGRect(x: 8, y: (view.frame.height-5) - aboutButtonSize.height, width: aboutButtonSize.width, height: aboutButtonSize.height))
        
        aboutButton.setTitle(aboutButtonText, for: .normal)
        aboutButton.setTitleColor(UIColor.white, for: .normal)
        aboutButton.titleLabel?.font = aboutButtonFont
        aboutButton.addTarget(self, action: #selector(segueToAboutVC), for: .touchUpInside)
        
        view.addSubview(aboutButton)
    }
    /*
    
    func configureResetButton() {
        let resetButtonText = "Reset"
        let resetButtonFont = UIFont.systemFont(ofSize: 15)
        let fontAttributes = [NSFontAttributeName: resetButtonFont]
        resetButtonSize = resetButtonText.size(attributes: fontAttributes)
        
        resetButtonSize.height += 16
        resetButtonSize.width = resetButtonSize.width + 16
        
        resetButton = UIButton(frame: CGRect(x: 138, y: (view.frame.height-5) - resetButtonSize.height, width: resetButtonSize.width, height: resetButtonSize.height))
        
        resetButton.setTitle(resetButtonText, for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = resetButtonFont
        aboutButton.addTarget(self, action: #selector(loadView), for: .touchUpInside)
        
        view.addSubview(resetButton)
        
        
    }
    */
    // MARK: - Segue
    
    func segueToAboutVC(sender: UIButton) {
        performSegue(withIdentifier: "ToAboutVC", sender: sender)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
      self.leftScore = 0
        self.rightScore = 0
        self.leftScoreLabel.text = "\(self.leftScore)"
        self.rightScoreLabel.text = "\(self.rightScore)"
        self.leftImageView.image = UIImage(named: "back")
        self.rightImageView.image = UIImage(named: "back")
        //loadView()
    }
 
    
    @IBAction func dealTapped(_ sender: UIButton) {
        
        //randomize left number from 0 to 12
        let leftNumber = Int(arc4random_uniform(13))
        
        //set the left image
        leftImageView.image = UIImage(named: cardNames[leftNumber])
        
        //randomize right number from 0 to 12
        let rightNumber = Int(arc4random_uniform(13))
        
        //set the right image
        rightImageView.image = UIImage(named: cardNames[rightNumber])
        
        //Compare card numbers
        if leftNumber > rightNumber {
            //left card wins
            
            //increment score
            leftScore += 1
            
            //update label
            leftScoreLabel.text = String(leftScore)
            
        } else if leftNumber == rightNumber{
            //it's a tie
            
        } else {
            //right card wins
            
            //increment score
            rightScore += 1
            
            //update label
            rightScoreLabel.text = String(rightScore)
            
        }
        
     playSound()
        
    }

}

