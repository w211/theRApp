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
    @IBOutlet weak var skipSlider: UISlider!
    
    var musicPlayer: AVAudioPlayer!
    var lyricArray = ["Yo", "sup", "player", "hello", "rap", "this", "song"]
    var x = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initAudio()
        updateSkipBar()
        updateLycrics()
        
    }
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("1", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            skipSlider.maximumValue = Float(musicPlayer.duration)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func updateLabel() {
        if x != lyricArray.count {
            let lyric = lyricArray[x]
            x++
            text.text = lyric
        } else {
            x = 0
        }
        
    }
    
    func updateLycrics() {
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("updateLabel"), userInfo: nil, repeats: true)
    }
    
    func updateSkipBar() {
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
    }
    
    func updateSlider() {
        skipSlider.value = Float(musicPlayer.currentTime)
    }

    @IBAction func playBtnPressed(sender: UIButton!) {
    
        if musicPlayer.playing {
            musicPlayer.stop()
            timer.invalidate()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            updateLycrics()
            sender.alpha = 10.0
        }
    
    }
    
    @IBAction func forwardBtnPressed(sender: AnyObject) {
        initAudio()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        initAudio()
    }
    
    @IBAction func volumeMoved(sender: AnyObject) {
        musicPlayer.volume = volume.value
    }
    
    @IBAction func skipSliderMoved(sender: AnyObject) {
        musicPlayer.currentTime = NSTimeInterval(skipSlider.value)
    }
    
    

}

