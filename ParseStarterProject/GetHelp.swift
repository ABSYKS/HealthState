//
//  GetHelp.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse
import CoreLocation
import AVFoundation
var Latlocation = [Double]()
var Longlocation = [Double]()
var timer = NSTimer()
var player: AVAudioPlayer = AVAudioPlayer()

class GetHelp: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func help(sender: AnyObject) {
        
        let med = PFObject(className: "Mediccal")
        med["FirstName"] = first[0]
        med["LastName"] = last[0]
        
        if(Longlocation.count > 0) && (Latlocation.count > 0){
            med["Longitude"] = Double("\(Longlocation[Longlocation.count - 1])")
            med["Latitude"] = Double("\(Latlocation[Latlocation.count - 1])")
        }
            
        else if(Longlocation.count == 0) {
            med["Longitude"] = 0
            med["Latitude"] =  0
        }
        
        med.saveInBackgroundWithBlock { (success, error) ->Void in
            print("Object has been saved.") }
    }
    
    var manager:CLLocationManager!
    var tYPE = "wav"
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func audioPlay(value: String, type: String) {
        
        let audiopath = NSBundle.mainBundle().pathForResource(value, ofType: type)
        do{
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audiopath!))
            player.play()
        }
            
        catch {
            //deal with error
        }
    }
    
    func readLocation(characters: Character, x: Double) {
        
        //MAKE SWITCH FOR EFFICIENCY
        
        //error at some point: bugger; to debug when bored.
        
        switch(characters) {
            
        case "." :
            delay(x) {
                self.audioPlay("Point", type: self.tYPE)
            }
            break;
            
        case "-" :
            delay(x) {
                self.audioPlay("Minus", type: self.tYPE)
            }
            break;
            
        case "0" :
            delay(x) {
                self.audioPlay("Zero", type: self.tYPE)
            }
            break;
            
        case "1" :
            delay(x) {
                self.audioPlay("One", type: self.tYPE)
            }
            break;
            
        case "2" :
            delay(x) {
                self.audioPlay("Two", type: self.tYPE)
            }
            break;
            
        case "3" :
            delay(x) {
                self.audioPlay("Three", type: self.tYPE)
            }
            break;
            
        case "4" :
            delay(x) {
                self.audioPlay("Four", type: self.tYPE)
            }
            break;
            
        case "5" :
            delay(x) {
                self.audioPlay("Five", type: self.tYPE)
            }
            break;
            
        case "6" :
            delay(x) {
                self.audioPlay("Six", type: self.tYPE)
            }
            break;
            
        case "7" :
            delay(x) {
                self.audioPlay("Seven", type: self.tYPE)
            }
            break;
            
        case "8" :
            delay(x) {
                self.audioPlay("Eight", type: self.tYPE)
            }
            break;
            
        case "9" :
            delay(x) {
                self.audioPlay("Nine", type: self.tYPE)
            }
            break;
            
        default: break;
            
        }
        
    }
    
    func locationAudio() {
        //LONGITUDE AUDIO
        let longg:String = "\(Longlocation[Longlocation.count - 1])"
        //            let string2:String = "\(Latlocation[Latlocation.count - 1])"
        var characters = [Character](longg.characters)
        let total = characters.count
        print(characters)
        
        self.audioPlay("Longitude", type: self.tYPE)
        
        for(var i = 1; i < 11; i++) {
            let x = (Double)(i)
            self.readLocation(characters[i-1], x: (x * 1.15) )
        }
        
        for(var i = 11; i < total+1; i++) {
            
            switch(i) {
            case total - 1:
                let x = (Double)(i) + 1
                self.readLocation(characters[i-1], x: x  )
                break;
                
            case total:
                let x = (Double)(i) + 2
                self.readLocation(characters[i-1], x: x  )
                
                delay(23){
                    let string2:String = "\(Latlocation[Latlocation.count - 1])"
                    var characters2 = [Character](string2.characters)
                    let total2 = characters2.count
                    print(characters2)
                    self.audioPlay("Latitude", type: self.tYPE)
                    
                    for(var j = 1; j <= total2 ; j += 1) {
                        let y = (Double)(j)
                        self.readLocation(characters2[j-1], x: (y * 1.15))
                    }
                }
                
                break;
                
            default:
                let x = (Double)(i)
                self.readLocation(characters[i-1], x: x  )
                break;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            manager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        manager.startUpdatingLocation()
    }
    
    //LOCATION SERVICES
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //userLocation - there is no need for casting, because we are now using CLLocation object
        let userLocation:CLLocation = locations[0]
        let lat = userLocation.coordinate.latitude
        Latlocation.append(lat)
        let long = userLocation.coordinate.longitude
        Longlocation.append(long)
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                //deal with error
            }
                
            else {
                
                if let p = placemarks?[0] {
                    var subThoroughfare:String = ""
                    if ((p.subThoroughfare != nil)&&(p.subLocality == nil)) {
                        subThoroughfare = p.subThoroughfare!
                    }
                    else if (p.subLocality != nil) {
                        _ = p.subLocality!
                    }
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
