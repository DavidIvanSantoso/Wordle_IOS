//
//  ViewController.swift
//  uts_davidivan_c14190040
//
//  Created by Athalia Gracia Santoso on 31/03/22.
//

import UIKit

class ViewController: UIViewController {

    var timer=Timer()
    var waktuawal=0
    var cnt=0
    var life=5
    var jawaban=""
    var arrWords:[String]=["ABOVE","ABOUT","ADULT","FUZZY","BLOOD","SALAD","LEMON","MELON","COLOR","EAGLE"]
    var rand=Int.random(in: 0...9)
    var choosenWord=""
    var cntisi=0
    var hijau=0
    var keyboardenable=true
    var enter=false
    
    @IBOutlet weak var winlose: UILabel!
    @IBOutlet var LabelBackground: [UIView]!
    @IBOutlet var allKeyboard: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        resetgame()
        print(choosenWord)
        TimerLabel.text=String(waktuawal)
        timer.invalidate()
        startTimer()
        // Do any additional setup after loading the view.
    }

    @IBAction func restartbtn(_ sender: Any) {
        resetgame()
        startTimer()
    }
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet var isiLabel: [UILabel]!
    
    @IBAction func keyboardbtn(_ sender: UIButton) {
        
        if(cnt==4 || cnt==9 || cnt==14 || cnt==19 || cnt==24){
            keyboardenable=false
        }
        else{
            keyboardenable=true
        }
        if(keyboardenable==false){
            for i in allKeyboard{
                if((i.titleLabel?.text!) != "⏎" || (i.titleLabel?.text!) != "⌫"){
                    i.isUserInteractionEnabled=false
                }
            }
        }
        if(keyboardenable==true){
            for i in allKeyboard{
                i.isUserInteractionEnabled=true
            }
        }
        if(sender.titleLabel?.text=="⏎"){
            hijau=0
            if(cnt == 5 || cnt == 10 || cnt == 15 || cnt == 20 || cnt == 25){
                if(hijau != 5 && life>0){
                    cntisi=cnt-5
                    life-=1
                    for a in choosenWord{
                        if(choosenWord.contains(isiLabel[cntisi].text!)){
                            if(isiLabel[cntisi].text==String(a)){
                                LabelBackground[cntisi].backgroundColor=UIColor.green
                                isiLabel[cntisi].textColor=UIColor.white
                                cntisi+=1
                                hijau+=1
                            }
                            else{
                                LabelBackground[cntisi].backgroundColor=UIColor.orange
                                isiLabel[cntisi].textColor=UIColor.white
                                cntisi+=1
                            }
                        }
                        else{
                            LabelBackground[cntisi].backgroundColor=UIColor.darkGray
                            isiLabel[cntisi].textColor=UIColor.white
                            cntisi+=1
                        }
                    }
                }
                if(hijau==5 && life != 0){
                    print("you win")
                    winlose.text="WIN"
                    winlose.textColor=UIColor.white
                    timer.invalidate()
                    for i in allKeyboard{
                        i.isUserInteractionEnabled=false
                    }
                }
                if (life<=0){
                    winlose.text="YOU LOSE"
                    timer.invalidate()
                }
            }
            
            keyboardenable=true
            
        }
        else if (sender.titleLabel?.text=="⌫"){
            if(cnt>=1){
                cnt-=1
                isiLabel[cnt].text=""
            }
        }
        else{
            isiLabel[cnt].text=sender.titleLabel?.text?.uppercased()
            cnt+=1
        
        }
    }
    
    func resetgame(){
        cnt=0
        rand=Int.random(in: 0...9)
        choosenWord=arrWords[rand]
        print(choosenWord)
        for label in isiLabel{
            label.text=""
        }
        timer.invalidate()
        waktuawal=0
        life=5
        for i in LabelBackground{
            i.backgroundColor=UIColor.white
        }
        for i in isiLabel{
            i.textColor=UIColor.black
        }
        for i in allKeyboard{
            if(i.titleLabel?.text! == "⏎"){
                i.isUserInteractionEnabled=false
            }
            i.isUserInteractionEnabled=true
        }
        winlose.text=""
    }
    
    @objc func updateTimer() -> Void
    {
        waktuawal=waktuawal+1
        let time = secondsToHoursMinutesSeconds(seconds: waktuawal)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func startTimer(){
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
    }
    func secondsToHoursMinutesSeconds(seconds:Int)->(Int,Int,Int)
    {
        return ((seconds/3600),((seconds%3600)/60),((seconds%3600)%60))
    }
    func makeTimeString(hours:Int,minutes:Int,seconds:Int)-> String{
        var TimeString=""
        TimeString+=String(format: "%02d", hours)
        TimeString+=" : "
        TimeString+=String(format: "%02d", minutes)
        TimeString+=" : "
        TimeString+=String(format: "%02d", seconds)
        return TimeString
    }
}

