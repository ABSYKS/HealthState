//
//  ProfilePage.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var image = [UIImage]()
var first = [String]()
var last = [String]()
var birthda = [String]()
var Econtact = [String]()
var Enumber = [String]()
var Erelationship = [String]()

class ProfilePage: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var firstN: UITextField!
    @IBOutlet weak var lastN: UITextField!
    @IBOutlet weak var bday: UITextField!
    @IBOutlet weak var ERContact: UITextField!
    @IBOutlet weak var ERNumber: UITextField!
    @IBOutlet weak var ERealtionship: UITextField!
    @IBOutlet weak var picButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.myImageView.layer.cornerRadius = self.myImageView.frame.size.width / 2;
        self.myImageView.clipsToBounds = true;
        self.myImageView.layer.borderWidth = 3.0;
        let color = UIColor.grayColor().CGColor
        let backgound = UIColor.blackColor();
        self.myImageView.layer.borderColor = color;
        self.myImageView.backgroundColor = backgound;
        
        //            NSUserDefaults.standardUserDefaults().setObject(image[0], forKey: "ProfilePicture")
        //           _ = NSUserDefaults.standardUserDefaults().objectForKey("ProfilePicture")
        //            (NSUserDefaults.standardUserDefaults().objectForKey("ProfilePicture"))
        //
        //              NSUserDefaults.standardUserDefaults().setObject(first[0], forKey: "FirstName")
        //              NSUserDefaults.standardUserDefaults().setObject(last[0], forKey: "ProfilePicture")
        
        //         Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func choosePic(sender: AnyObject) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .ScaleAspectFit //3
        myImageView.image = chosenImage //4
        image.append(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
        picButton.enabled = false
        if(image.count > 0){
            picButton.setTitleColor(UIColor.clearColor(), forState: .Disabled)
        }
    }
    
    @IBAction func done(sender: AnyObject) {
        
        let fname = self.firstN.text
        let fnumber = fname?.characters.count
        let lname = self.lastN.text
        let lnumber = lname?.characters.count
        let birthday = self.bday.text
        let bnumber = birthday?.characters.count
        let emergencyName = self.ERContact.text
        let eNnumber = emergencyName?.characters.count
        let emergencyNumber = self.ERNumber.text
        let eNumNumber = emergencyNumber?.characters.count
        let emergencyRelationship = self.ERealtionship.text
        let eRNumber = emergencyRelationship?.characters.count
        
        if((fnumber != 0)&&(lnumber != 0)&&(bnumber != 0)&&(eNnumber != 0)&&(eNumNumber != 0)&&(eRNumber != 0)) {
            performSegueWithIdentifier("menu", sender: self)
            first.append(fname!)
            last.append(lname!)
            birthda.append(birthday!)
            Econtact.append(emergencyName!)
            Enumber.append(emergencyNumber!)
            Erelationship.append(emergencyRelationship!)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(fname, forKey: "First")
            defaults.setObject(lname, forKey: "Last")
            defaults.setObject(birthday, forKey: "Birthday")
            defaults.setObject(emergencyName, forKey: "EmergencyContact")
            defaults.setObject(emergencyNumber, forKey: "EmergencyNumber")
            defaults.setObject(emergencyRelationship, forKey: "EmergencyRelationship")
            defaults.synchronize()
            first[0] = defaults.objectForKey("First") as! String
            last[0] = defaults.objectForKey("Last") as! String
            birthda[0] = defaults.objectForKey("Birthday") as! String
            Econtact[0] = defaults.objectForKey("EmergencyContact") as! String
            Enumber[0] = defaults.objectForKey("EmergencyNumber") as! String
            Erelationship[0] = defaults.objectForKey("EmergencyRelationship") as! String
            
            let info = PFObject(className: "ProfileInformation")
            info["Birthday"] = birthda[0]
            info["EmergencyContact"] = Econtact[0]
            info["EmergencyNumber"] = Enumber[0]
            info["RelationshipToContact"] = Erelationship[0]
            info.saveInBackgroundWithBlock { (success, error) ->Void in
                print("Object has been saved.") }
        }
            
        else{
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Invalid", message:"You must answer all fields", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            } else {
                // Fallback on earlier versions
            }
        }
    }
}