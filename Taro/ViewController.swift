//
//  ViewController.swift
//  Taro
//
//  Created by gui lan on 11/9/17.
//  Copyright © 2017-2018 Gui. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    var gameState = [0,0,0,0,0,0,0,0,0]
    
    let winCombinations = [[0,1,2],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8],[3,4,5],[6,7,8]]
    
    var activePlayer = 1 //Totoro
    var gameActive = true
    
    @IBOutlet weak var TextField: UILabel!

    @IBAction func action(_ sender: UIButton) {
        if (gameState[sender.tag-1] == 0 && gameActive == true) {
            
            //hide the button
            //TextField.isHidden = true
            //playAgainButton.isHidden = false
            //beyond, I want to hide these two at first glance, can do this in attributes area,click"hidden"
            
            gameState[sender.tag-1] = activePlayer
            if (activePlayer == 1) {
                //show Totoro
                sender.setImage(UIImage(named: "Totoro.jpeg"), for: UIControlState())
                activePlayer = 2
            } else {
                //show blueTotoro
                sender.setImage(UIImage(named: "blueTotoro.jpeg"), for: UIControlState())
                activePlayer = 1
            }
        }
        
        for combination in winCombinations {
            if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
               
                //add the sound
                //winSound.play()
                gameActive = false
                if (gameState[combination[0]] == 1) {
                    // print("yeah totoro")
                    TextField.text = "Totoro has won!"
                } else {
                    TextField.text = "blueTotoro has won!"
                }
                
                TextField.isHidden = false
                playAgainButton.isHidden = false
                winSound.play()
            }
        }
        
        //if there is a draw
        gameActive = false
        
        for state in gameState {
            if state == 0 {
                gameActive = true
                break
            }
        }
        
        if (gameActive == false) {
            TextField.text = "This was a draw!"
            TextField.isHidden = false
            playAgainButton.isHidden = false
        }
    }



    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgainButton(_ sender: UIButton) {
        
        //set up
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1 //Totoro
        gameActive = true
        
        //clear the data
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
        //play the game again
        //hide the label and button
        TextField.isHidden = true
        playAgainButton.isHidden = true
    }
    
    //add sounds
    var hitSound: AVAudioPlayer = AVAudioPlayer()
    var winSound: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicFile = Bundle.main.path(forResource: "sound", ofType: ".wav")
        
        do {
            try hitSound = AVAudioPlayer(contentsOf: URL (fileURLWithPath:musicFile!))
        }
        catch {
            print(error)
        }
        
        let musicFileTwo = Bundle.main.path(forResource: "winSound", ofType: ".mp3")
      
        do {
            try winSound = AVAudioPlayer(contentsOf: URL (fileURLWithPath: musicFileTwo!))
        }
        catch {
            print(error)
        }
        
    }
    
    @IBAction func playsSounds(_ sender: UIButton) {
        hitSound.play()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

