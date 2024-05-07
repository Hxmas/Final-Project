//
//  RoutineVc.swift
//  TaskManager
//
//  Created by Hamas Mahroof on 26/04/2024.
//

import UIKit
import AVFoundation

class RoutineVc: UIViewController {
        var countdownTimer: Timer?
        var totalTime = 0
        var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var counterBackground: UIView!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var totalGoalLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var totalRoundLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!

    var isCurrentModeisSession = true {
        didSet {
            if isCurrentModeisSession{
                self.sessionLabel.text = "Session Time"
                self.counterBackground.backgroundColor = .systemGray3
               

                
            }else {
                self.sessionLabel.text = "Break Time"
                self.counterBackground.backgroundColor = .systemRed
                 
            }
           // startSession()

        }
    }
    
    var isCountDownRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

      
        if AppSettings.currentRound >= AppSettings.totalRound {
            AppSettings.currentRound = 0
        }
        initData()
        setTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
       
    }
    
    
    
    func initData(){
        
        updateStats()
        timerLabel.text = formatTime(totalTime)
        countdownTimer?.invalidate()
    }
    
    @IBAction func sessionBtnTapped(_ sender: UIButton) {
        isCurrentModeisSession.toggle()
        if isCurrentModeisSession{
            
            totalTime = AppSettings.sessionTime * 60

        }else {
          
            totalTime = AppSettings.breakTime * 60
 
        }
    }
    @IBAction func settingBtnTapped(_ sender: UIButton) {
    }
    @IBAction func resetBtnTaapped(_ sender: UIButton) {
     
        AppSettings.currentGoal = 0
        AppSettings.currentRound = 0
        isCountDownRunning = false
        updateStats()
        playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
    }
    @IBAction func startBtnTapped(_ sender: UIButton) {
        
      
        isCountDownRunning.toggle()
     
        if isCountDownRunning {
           // setTimer()
            playButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)

            startSession()
        }else{
            countdownTimer?.invalidate()
            audioPlayer?.stop()
            playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)

        }

    }
    
    func setTimer(){
        if isCurrentModeisSession{
            
            totalTime = AppSettings.sessionTime * 60

        }else {
          
            totalTime = AppSettings.breakTime * 60
 
        }
        timerLabel.text = formatTime(totalTime)

        if !isCountDownRunning{
          
            playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
        }else {
            playButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)

        }
    }
    // managing session and break count down
    func startSession() {
            countdownTimer?.invalidate()
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
           playTickSound()
        }

        @objc func updateTimer() {
           
            totalTime -= 1
            timerLabel.text = formatTime(totalTime)

            if totalTime <= 0 {
                countdownTimer?.invalidate()
                countdownTimer = nil
                // Stop the ticking sound
                audioPlayer?.stop()
                if isCurrentModeisSession {
                    if AppSettings.currentRound < AppSettings.totalRound {
                        AppSettings.currentRound += 1
                        setTimer()
                    }else {
                        if AppSettings.currentGoal < AppSettings.totalGoals {
                            AppSettings.currentGoal += 1
                            AppSettings.currentRound = 0
                        }
                        
                    }
                    updateStats()

                }else {
                    
                }
                self.isCountDownRunning = false
                playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)

            }else {
             
            }
           // initData()
        }

        func formatTime(_ totalSeconds: Int) -> String {
            let minutes = totalSeconds / 60
            let seconds = totalSeconds % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }

        func playTickSound() {
            guard let url = Bundle.main.url(forResource: "tick", withExtension: "mp3") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.play()
            } catch {
                print("Unable to play the tick sound.")
            }
        }
    
    func updateStats(){
       
        totalGoalLabel.text =  "/\(AppSettings.totalGoals)"
        totalRoundLabel.text =  "/\(AppSettings.totalRound)"
        roundLabel.text =  "\(AppSettings.currentRound)"
        goalLabel.text =  "\(AppSettings.currentGoal)"
        
      

    }
    
}


