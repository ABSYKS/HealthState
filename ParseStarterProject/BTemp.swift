//
//  BTemp.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

  
import UIKit

var averageBodyTemperature = [Double]()
var averageRoomTemperature = [Double]()
class BTemp: UIViewController {
    
    var timer = NSTimer();
    @IBOutlet weak var bodyAvg: UILabel!
    @IBOutlet weak var roomAvg: UILabel!
    @IBOutlet weak var bodyTemperature: UILabel!
    @IBOutlet weak var roomTemperature: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var roomText: UILabel!
    
    let lightcolor = UIColor.init(red: 51/255, green: 210/255, blue: 153/255, alpha: 0.9)
    let licolor = UIColor.init(red: 51/255, green: 200/255, blue: 133/255, alpha: 0.9)
    
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
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(BTemp.updateAllTemp), userInfo: nil, repeats: true)
    }
    
    func updateAllTemp() {
        updateBodyTemp();
        updateRoomTemperature();
        updateTemperatureAverages();
    }
    
    func updateBodyTemp(){
        let bodyTemp = randomRange(36.0, j: 41)
        averageBodyTemperature.append((bodyTemp))
        bodyTemperature.text = (String)(round(bodyTemp * 100)/100)
        switch(true) {
        case bodyTemp > 37.5 && bodyTemp < 38.0: bodyText.text = "You seem to be getting a temperature. I would avdise your doctor."
        break;
        case bodyTemp > 38.1: bodyText.text = "You have a fever, please go see your doctor. In the meantime, 500mg of Ibuprofen should help with the temperature."
        break;
        case bodyTemp < 36 && bodyTemp > 35: bodyText.text = "Please warm yourself up to avoid getting ill. Your body temperature is too low."
        break;
        case 35 > bodyTemp && bodyTemp >= 32: bodyText.text = "Your body temperature is too low.You are at serious risk."
        break;
        default: bodyText.text = "Your body temperature is perfectly normal."
        break;
        }
    }
    
    func updateRoomTemperature() {
        let roomTemp = randomRange( 16.0, j: 25.0)
        averageRoomTemperature.append((roomTemp))
        roomTemperature.text = (String)(round(roomTemp * 100)/100)
        roomText.text = "Room temperature is \((Int)(roomTemp)) degrees Celsius."
    }
    
    func updateTemperatureAverages() {
        let roomNum = averageRoomTemperature.count
        let bodyNum = averageBodyTemperature.count
        
        if (roomNum % 10 == 0) && (averageRoomTemperature.count != 0) {
            let averageRT = round(averageRoomTemperature.reduce(0, combine: +) / (Double)(roomNum))
            roomAvg.text = "\(averageRT)"
        }
        
        if (bodyNum % 10 == 0) && (averageBodyTemperature.count != 0){
            let averageBT = round(averageBodyTemperature.reduce(0, combine: +) / (Double)(bodyNum))
            bodyAvg.text = "\(averageBT)"
        }
    }
    
    func circleGenerator(let x: Int, let y: Int, let color: UIColor) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x,y:y), radius: CGFloat(45), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
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
        circleGenerator(71, y: 291, color: lightcolor)
        circleGenerator(246, y: 451, color: licolor)
        myTimer();
        roomTemperature.text = "..."
        bodyTemperature.text = "..."
        bodyText.text = "Calculating..."
        roomText.text = "Calculating..."
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
