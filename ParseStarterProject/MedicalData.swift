//
//  MedicalData.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var medicalStatus = [String]()
var height = [String]()
var weight = [String]()
var bloodtype = [String]()
var conditions = [String]()
var addressStreetAndNumber = [String]()
var addressCity = [String]()
var addressState = [String]()
var addressCountry = [String]()

class MedicalData: UIViewController {
    
    @IBOutlet weak var heightt: UITextField!
    @IBOutlet weak var weightt: UITextField!
    @IBOutlet weak var bloodType: UITextField!
    @IBOutlet weak var existingConditions: UITextField!
    @IBOutlet weak var streetAndNumber: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var country: UITextField!
    
    let hnumber = height.count
    let wnumber = weight.count
    let bloodnum = bloodtype.count
    let countryanum = addressCountry.count
    let snumber = addressState.count
    let cNum = addressCity.count
    let strnum = addressStreetAndNumber.count
    let ecnum = conditions.count
    
    
    //    @IBAction func newConditions(sender: AnyObject) {
    //
    //        if ((existingConditions.text != nil)&&(existingConditions.text != "Existing Conditions:")){
    //
    //            performSegueWithIdentifier("neCondition", sender:nil)
    //        }
    //
    //        else{
    //
    //            let alert = UIAlertController(title: "Invalid!", message: "You have not filled in your existing conditions.", preferredStyle: .Alert)
    //            let action = UIAlertAction(title: "OK", style: .Default) { _ in
    //
    //            }
    //            alert.addAction(action)
    //            self.presentViewController(alert, animated: true){}
    //        }
    //
    //    }
    
    @IBAction func done(sender: AnyObject) {
        
        
        let h = heightt.text
        let hc = h?.characters.count
        let w = weightt.text
        let wc = w?.characters.count
        let blood = bloodType.text
        let bloodc = blood?.characters.count
        let ec = existingConditions.text
        let ecc = ec?.characters.count
        let countrya = country.text
        let countryac = countrya?.characters.count
        let s = state.text
        let sc = s?.characters.count
        let c = city.text
        let cc = c?.characters.count
        let str = streetAndNumber.text
        let strc = str?.characters.count
        
        //If all fields are entered diable alerts & take in data
        
        if((heightt.text != "Height:")&&(weightt.text != "Weight:")&&(country.text != "Country:")&&(city.text != "City:")&&(state.text != "State:")&&(streetAndNumber.text != "Street and number:")&&(bloodType.text != "Blood-type:")){
            
            
            height.append(h!)
            weight.append(w!)
            bloodtype.append(blood!)
            conditions.append(ec!)
            addressStreetAndNumber.append(str!)
            addressState.append(s!)
            addressCountry.append(countrya!)
            addressCity.append(c!)
            medicalStatus.append("Complete")
            performSegueWithIdentifier("doneWithData", sender: self)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(heightt.text, forKey: "Height")
            defaults.setObject(weightt.text, forKey: "Weight")
            defaults.setObject(bloodType.text, forKey: "BloodType")
            defaults.setObject(existingConditions.text, forKey: "ExistConditions")
            defaults.setObject(country.text, forKey: "Country")
            defaults.setObject(state.text, forKey: "State")
            defaults.setObject(city.text, forKey: "City")
            defaults.setObject(streetAndNumber.text, forKey: "StreetAndNumber")
            defaults.synchronize()
            
            height[0] = defaults.objectForKey("Height") as! String
            weight[0] = defaults.objectForKey("Weight") as! String
            bloodtype[0] = defaults.objectForKey("BloodType") as! String
            conditions[0] = defaults.objectForKey("ExistConditions") as! String
            addressStreetAndNumber[0] = defaults.objectForKey("StreetAndNumber") as! String
            addressCity[0] = defaults.objectForKey("City") as! String
            addressState[0] = defaults.objectForKey("State") as! String
            addressCountry[0] = defaults.objectForKey("Country") as! String
            
            let info = PFObject(className: "MedicalInformation")
            info["Height"] = h
            info["Weight"] = w
            info["Country"] = countrya
            info["State"] = s
            info["City"] = c
            info["StreetAndNumber"] = str
            info.saveInBackgroundWithBlock { (success, error) ->Void in
                print("Object has been saved.") }
            
        }
            
            //Display alert if required fields aren't entered
            
        else if((country.text != "Country:")&&(city.text != "City:")&&(state.text != "State:")&&(streetAndNumber.text != "Street and number:")){
            height.append(h!)
            weight.append(w!)
            bloodtype.append(blood!)
            conditions.append(ec!)
            addressStreetAndNumber.append(str!)
            addressState.append(s!)
            addressCountry.append(countrya!)
            addressCity.append(c!)
            performSegueWithIdentifier("doneWithData", sender: self)
        }
            
        else{
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Invalid", message: "You must fill in the required fields.", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            } else {
                // Fallback on earlier versions
            }

            
        }
        
        //allow placeholder editing
        
        func textViewDidBeginEditing(heightt: UITextView, weightt: UITextView, bloodType: UITextView, existingConditions: UITextView, streetAndNumber: UITextView, city: UITextView, state: UITextView, country: UITextView) {
            if heightt.textColor == UIColor.blackColor(){
                heightt.text = nil
                heightt.textColor = UIColor.blackColor()
            }
            if weightt.textColor == UIColor.blackColor() {
                weightt.text = nil
                weightt.textColor = UIColor.blackColor()
            }
            if bloodType.textColor == UIColor.blackColor() {
                bloodType.text = nil
                bloodType.textColor = UIColor.blackColor()
            }
            if existingConditions.textColor == UIColor.blackColor() {
                existingConditions.text = nil
                existingConditions.textColor = UIColor.blackColor()
            }
            if streetAndNumber.textColor == UIColor.blackColor() {
                streetAndNumber.text = nil
                streetAndNumber.textColor = UIColor.blackColor()
            }
            if city.textColor == UIColor.blackColor() {
                city.text = nil
                city.textColor = UIColor.blackColor()
            }
            if state.textColor == UIColor.blackColor() {
                state.text = nil
                state.textColor = UIColor.blackColor()
            }
            if country.textColor == UIColor.blackColor() {
                country.text = nil
                country.textColor = UIColor.blackColor()
            }
            
        }
        
        //end placeholder editting
        
        func textViewDidEndEditing(heightt: UITextView, weightt: UITextView, bloodType: UITextView, existingConditions: UITextView, streetAndNumber: UITextView, city: UITextView, state: UITextView, country: UITextView) {
            
            if heightt.text.isEmpty {
                heightt.text = "\(height[hnumber - 1])"
                heightt.textColor = UIColor.lightGrayColor()
            }
            if weightt.text!.isEmpty {
                weightt.text = "\(weight[wnumber - 1])"
                weightt.textColor = UIColor.lightGrayColor()
            }
            if bloodType.text!.isEmpty {
                bloodType.text = "\(bloodtype[bloodnum - 1])"
                bloodType.textColor = UIColor.lightGrayColor()
            }
            if existingConditions.text!.isEmpty {
                existingConditions.text = "\(conditions[ecnum - 1])"
                existingConditions.textColor = UIColor.lightGrayColor()
            }
            if city.text!.isEmpty {
                city.text = "\(addressCity[cNum - 1])"
                city.textColor = UIColor.lightGrayColor()
            }
            if streetAndNumber.text!.isEmpty {
                streetAndNumber.text = "\(addressStreetAndNumber[strnum - 1])"
                streetAndNumber.textColor = UIColor.lightGrayColor()
            }
            if state.text!.isEmpty {
                state.text = "\(addressState[snumber - 1])"
                state.textColor = UIColor.lightGrayColor()
            }
            if country.text!.isEmpty {
                country.text = "\(addressCountry[countryanum - 1])"
                country.textColor = UIColor.lightGrayColor()
            }
        }
        
    }
    
    //load at first
    
    override func viewDidAppear(animated: Bool) {
        let hnumber = height.count
        let wnumber = weight.count
        let bloodnum = bloodtype.count
        let countryanum = addressCountry.count
        let snumber = addressState.count
        let cNum = addressCity.count
        let strnum = addressStreetAndNumber.count
        let ecnum = conditions.count
        
        
        if((hnumber != 0)&&(heightt != "Height:")&&(wnumber != 0)&&(weightt != "Weight:")&&(bloodnum != 0)&&(countryanum != 0)&&(country != "Country:")&&(cNum != 0)&&(city != "City:")&&(snumber != 0)&&(state != "State:")&&(strnum != 0)&&(streetAndNumber != "Street and number:")&&(ecnum != 0)){
            
            heightt.text = "\(height[hnumber - 1])"
            heightt.textColor = UIColor.lightGrayColor()
            weightt.text = "\(weight[wnumber - 1])"
            weightt.textColor = UIColor.lightGrayColor()
            bloodType.text = "\(bloodtype[bloodnum - 1])"
            bloodType.textColor = UIColor.lightGrayColor()
            existingConditions.text = "\(conditions[ecnum - 1])"
            existingConditions.textColor = UIColor.lightGrayColor()
            city.text = "\(addressCity[cNum - 1])"
            city.textColor = UIColor.lightGrayColor()
            streetAndNumber.text = "\(addressStreetAndNumber[strnum - 1])"
            streetAndNumber.textColor = UIColor.lightGrayColor()
            state.text = "\(addressState[snumber - 1])"
            state.textColor = UIColor.lightGrayColor()
            country.text = "\(addressCountry[countryanum - 1])"
            country.textColor = UIColor.lightGrayColor()
            
        }
            
        else{
            
            heightt.text = "Height:"
            heightt.textColor = UIColor.lightGrayColor()
            weightt.text = "Weight:"
            weightt.textColor = UIColor.lightGrayColor()
            //            bloodType.text = "Blood-type:"
            //            bloodType.textColor = UIColor.lightGrayColor()
            //            existingConditions.text = "Existing Conditions:"
            //            existingConditions.textColor = UIColor.lightGrayColor()
            city.text = "City:"
            city.textColor = UIColor.lightGrayColor()
            streetAndNumber.text = "Street and number:"
            streetAndNumber.textColor = UIColor.lightGrayColor()
            state.text = "State:"
            state.textColor = UIColor.lightGrayColor()
            country.text = "Country:"
            country.textColor = UIColor.lightGrayColor()
        }
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
