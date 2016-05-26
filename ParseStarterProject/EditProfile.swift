//
//  EditProfile.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
 
class EditProfile: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastnaem: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emrgencyContact: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var eRelationship: UITextField!
    let firstnumber = first.count
    let lastnumber = last.count
    let birth = birthda.count
    let emailli = mailList.count
    let emerecnyC = Econtact.count
    let emergencyNum = Enumber.count
    let emergencyRel = Erelationship.count
    
    //Profile Picture
    let picker = UIImagePickerController()
    @IBOutlet weak var imagePic: UIImageView!
    
    @IBAction func removeImage(sender: AnyObject) {
        imagePic.image = nil
    }
    
    @IBAction func changePicture(sender: AnyObject) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
        let numberImage = image.count
        imagePic.image = image[numberImage - 1]
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imagePic.contentMode = .ScaleAspectFit //3
        imagePic.image = chosenImage //4
        image.append(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    //show info once page has loaded
    func runimageloader(){
        let numberImage = image.count
        imagePic.image = image[numberImage - 1]
    }
    
    override func viewDidAppear(animated: Bool){
        //        displayinfo()
        runimageloader()
        
        //placeholder
        firstname.text = "\(first[firstnumber - 1])"
        firstname.textColor = UIColor.lightGrayColor()
        lastnaem.text = "\(last[lastnumber - 1])"
        lastnaem.textColor = UIColor.lightGrayColor()
        birthday.text = "\(birthda[birth - 1])"
        birthday.textColor = UIColor.lightGrayColor()
        email.text = "\(mailList[emailli - 1])"
        email.textColor = UIColor.lightGrayColor()
        emrgencyContact.text = "\(Econtact[emerecnyC - 1])"
        emrgencyContact.textColor = UIColor.lightGrayColor()
        contactNumber.text = "\(Enumber[emergencyNum - 1])"
        contactNumber.textColor = UIColor.lightGrayColor()
        eRelationship.text = "\(Erelationship[emergencyRel - 1])"
        eRelationship.textColor = UIColor.lightGrayColor()
    }
    
    @IBAction func done(sender: AnyObject) {
        let fname = self.firstname.text
        let fnumber = fname?.characters.count
        let lname = self.lastnaem.text
        let lnumber = lname?.characters.count
        let birthday = self.birthday.text
        let bnumber = birthday?.characters.count
        let emergencyName = self.emrgencyContact.text
        let emaills = self.email.text
        let emailNo = emaills?.characters.count
        let eNnumber = emergencyName?.characters.count
        let emergencyNumber = self.contactNumber.text
        let eNumNumber = emergencyNumber?.characters.count
        let emergencyRelationship = self.eRelationship.text
        let eRNumber = emergencyRelationship?.characters.count
        
        
        if((fnumber != 0)&&(lnumber != 0)&&(bnumber != 0)&&(eNnumber != 0)&&(eNumNumber != 0)&&(eRNumber != 0)) {
            performSegueWithIdentifier("backToProfile", sender: self)
            first.append(fname!)
            last.append(lname!)
            birthda.append(birthday!)
            mailList.append(emaills!)
            Econtact.append(emergencyName!)
            Enumber.append(emergencyNumber!)
            Erelationship.append(emergencyRelationship!)
            let info = PFObject(className: "NewProfileInformation")
            info["FirstName"] = first[firstnumber - 1]
            info["LastName"] = last[lastnumber - 1]
            info["Birthday"] = birthda[birth - 1]
            info["EmergencyContact"] = Econtact[emerecnyC - 1]
            info["EmergencyNumber"] = Enumber[emergencyNum - 1]
            info["RelationshipToContact"] = Erelationship[emergencyNum - 1]
            info["Email"] = mailList[list - 1]
            info.saveInBackgroundWithBlock { (success, error) ->Void in
                print("Object has been saved.") }
            
        }
            
        else {
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Oops!", message:"You must fill in all fields...", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
                
            } else {
                // Fallback on earlier versions
            }

        }
        
        func textViewDidBeginEditing(firstname: UITextView, lastname: UITextView, birthday: UITextView, email: UITextView, emergencyContact: UITextView, contactNumber: UITextView, eRelationship: UITextView) {
            if firstname.textColor == UIColor.lightGrayColor() {
                firstname.text = nil
                firstname.textColor = UIColor.blackColor()
            }
            if lastname.textColor == UIColor.lightGrayColor() {
                lastname.text = nil
                lastname.textColor = UIColor.blackColor()
            }
            if birthday.textColor == UIColor.lightGrayColor() {
                birthday.text = nil
                birthday.textColor = UIColor.blackColor()
            }
            if email.textColor == UIColor.lightGrayColor() {
                email.text = nil
                email.textColor = UIColor.blackColor()
            }
            if emergencyContact.textColor == UIColor.lightGrayColor() {
                emergencyContact.text = nil
                emergencyContact.textColor = UIColor.blackColor()
            }
            if contactNumber.textColor == UIColor.lightGrayColor() {
                contactNumber.text = nil
                contactNumber.textColor = UIColor.blackColor()
            }
            if eRelationship.textColor == UIColor.lightGrayColor() {
                eRelationship.text = nil
                eRelationship.textColor = UIColor.blackColor()
            }
        }
        
        func textViewDidEndEditing(firstname: UITextView, lastname: UITextView, birthday: UITextView, email: UITextView, emergencyContact: UITextView, contactNumber: UITextView, eRelationship: UITextView) {
            let firstnumber = first.count
            let lastnumber = last.count
            let birth = birthda.count
            let emailli = mailList.count
            let emerecnyC = Econtact.count
            let emergencyNum = Enumber.count
            let emergencyRel = Erelationship.count
            
            if firstname.text.isEmpty {
                firstname.text = "\(first[firstnumber - 1])"
                firstname.textColor = UIColor.lightGrayColor()
            }
            if lastname.text!.isEmpty {
                lastname.text = "\(last[lastnumber - 1])"
                lastname.textColor = UIColor.lightGrayColor()
            }
            if birthday.text!.isEmpty {
                birthday.text = "\(birthda[birth - 1])"
                birthday.textColor = UIColor.lightGrayColor()
            }
            if email.text!.isEmpty {
                email.text = "\(mailList[emailli - 1])"
                email.textColor = UIColor.lightGrayColor()
            }
            if emergencyContact.text!.isEmpty {
                emergencyContact.text = "\(Econtact[emerecnyC - 1])"
                emergencyContact.textColor = UIColor.lightGrayColor()
            }
            if contactNumber.text!.isEmpty {
                contactNumber.text = "\(Enumber[emergencyNum - 1])"
                contactNumber.textColor = UIColor.lightGrayColor()
            }
            if eRelationship.text!.isEmpty {
                eRelationship.text = "\(Erelationship[emergencyRel - 1])"
                eRelationship.textColor = UIColor.lightGrayColor()
            }
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
        if(image.count > 0) {
            picker.delegate = self
            self.imagePic.layer.cornerRadius = self.imagePic.frame.size.width / 2;
            self.imagePic.clipsToBounds = true;
            self.imagePic.layer.borderWidth = 3.0;
            let color = UIColor.grayColor().CGColor
            let backgound = UIColor.blackColor();
            self.imagePic.layer.borderColor = color;
            self.imagePic.backgroundColor = backgound;
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
