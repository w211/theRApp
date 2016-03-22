//
//  ViewController.swift
//  TheRApp
//
//  Created by Marshall Cuico on 3/22/16.
//  Copyright © 2016 Marshall Cuico. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var volume: UISlider!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var skip: UISlider!
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initAudio()
        
    }
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("1", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func playBtnPressed(sender: UIButton!) {
    
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 10.0
        }
    
    }
    
    @IBAction func forwardBtnPressed(sender: AnyObject) {
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        initAudio()s
    }
    
    @IBAction func volumeMoved(sender: AnyObject) {
            musicPlayer.volume = volume.value
    }
    
    @IBAction func skipSliderMoved(sender: AnyObject) {
    }
    
    

}

