//
//  HeartVitals.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//


import Foundation
import UIKit

var currentHeartRate = [Double]()
var averageHeartRate = [Double]()

class HeartVitals: UIViewController {
    
    var timer = NSTimer();
    var HROutput = UILabel()
    
    @IBOutlet weak var HRoutput: UILabel!
    @IBOutlet weak var medicalOutput: UILabel!
    @IBOutlet weak var avgPercentage: UILabel!
    @IBOutlet weak var currentPercentage: UILabel!
    @IBOutlet weak var BPMlab: UILabel!
    @IBOutlet weak var BPMCurrent: UILabel!
    
    let lightGreen = UIColor.init(red: 51/255, green: 255/255, blue: 153/255, alpha: 0.9)
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func randomRange(i: Double, j: Double) -> Double {
        let range = i - j;
        let input = randomCGFloat()
        let output = (Double(input) * range) + j;
        return output;
    }
    
    func myTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.updateDisplays), userInfo: nil, repeats: true)
    }
    
    func updateDisplays() {
        updateHR();
        updatePercentage();
        updateAverages();
    }
    
    func updateHR(){
        
        let heartRate = randomRange(130, j: 60)
        let outs = Int(heartRate)
        let arrNum = (Double)(currentHeartRate.count)
        currentHeartRate.append((heartRate))
        HRoutput.text = (String)(outs)
        
        switch(true){
        case outs > 110: medicalOutput.text = "Your heart rate is abnormally high. Try to slow down a little or go see your doctor ASAP."
        break;
        case heartRate <= 10: medicalOutput.text = "Your heart rate is too low, you are undergoing a form of bradycardia. Help is on its way."
        break;
        default: medicalOutput.text = "Your heart-rate is completely normal. With more exercise your resting heart-rate will decrease."
        break;
        }
        
        if (currentHeartRate.count > 1) {
            BPMlab.text = (String)(round(currentHeartRate.reduce(0, combine: +) / arrNum))
            BPMCurrent.text = (String)(round(currentHeartRate[currentHeartRate.count - 1]))
        }
        else {
            BPMlab.text = ("N/A");
            BPMCurrent.text = ("N/A");
        }
    }
    
    func updatePercentage() {
        
        //current percentage
        if (currentHeartRate.count > 1) {
            
            let currPercDiff: Double = (Double)((currentHeartRate[currentHeartRate.count - 1]) / (currentHeartRate[currentHeartRate.count - 2])) * 100.0
            let currPrecDiffOut = (round(currPercDiff*100)/100)
            
            if (currPercDiff > 0.0) {
                currentPercentage.text = (String)(currPrecDiffOut);
                currentPercentage.textColor = UIColor.init(red: 0, green: 255/255, blue: 153/255, alpha: 1)
            }
            else {
                currentPercentage.text = (String)(currPrecDiffOut);
                currentPercentage.textColor = UIColor.init(red: 255/255, green: 51/255, blue: 41/255, alpha: 1)
            }
        }
    }
    
    func updateAverages() {
        //average percentage
        let arrNum = (Double)(currentHeartRate.count)
        if (((currentHeartRate.count % 10) == 0) && (currentHeartRate.count != 0)) {
            let average = round((currentHeartRate.reduce(0, combine: +)) / arrNum)
            averageHeartRate.append(average);
            if(averageHeartRate.count > 1) {
                let avgPercDiff = ((averageHeartRate[averageHeartRate.count - 2]) / (averageHeartRate[averageHeartRate.count - 1])) * 100
                let text = (String)(avgPercDiff)
                
                if (avgPercDiff > 0) {
                    avgPercentage.text = text;
                    avgPercentage.textColor = UIColor.init(red: 0, green: 255/255, blue: 153/255, alpha: 1)
                }
                else {
                    avgPercentage.text = text;
                    avgPercentage.textColor = UIColor.init(red: 255/255, green: 51/255, blue: 41/255, alpha: 1)
                }
            }
        }
    }
    
    func circleGenerator(let x: Int, let r: Int, let color: UIColor) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x,y:305), radius: CGFloat(r), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = color.CGColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer)
    }
    
    override func viewDidLoad() {
        circleGenerator(160,r: 75, color: lightGreen)
        
        myTimer();
        avgPercentage.text = "..."
        currentPercentage.text = "..."
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}