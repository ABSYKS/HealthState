//
//  UserProfile.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
 
class UserProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var ecname: UITextField!
    @IBOutlet weak var ecnumber: UITextField!
    @IBOutlet weak var ecrelationship: UITextField!
    @IBOutlet weak var fullname: UILabel!
    let picker = UIImagePickerController()
    @IBAction func removePic(sender: AnyObject) {
        myImage.image = nil
    }
    
    @IBAction func changePic(sender: AnyObject) {
        
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
        let numberImage = image.count
        myImage.image = image[numberImage - 1]
    }
    
    @IBAction func choosePicturFromLibrary(sender: AnyObject) {
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
        myImage.contentMode = .ScaleAspectFit //3
        myImage.image = chosenImage //4
        image.append(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    
    func displayinfo() {
        
        let firstnumber = first.count
        let lastnumber = last.count
        let birth = birthda.count
        let emailli = mailList.count
        let emerecnyC = Econtact.count
        let emergencyNum = Enumber.count
        let emergencyRel = Erelationship.count
        
        emailAdress.text = "\(mailList[emailli - 1])"
        birthday.text = "\(birthda[birth - 1])"
        ecname.text = "\(Econtact[emerecnyC - 1])"
        ecnumber.text = "\(Enumber[emergencyNum -  1])"
        ecrelationship.text = "\(Erelationship[emergencyRel - 1])"
        fullname.text = "\(first[firstnumber - 1]) \(last[lastnumber - 1])"
    }
    
    func runimageloader(){
        myImage.contentMode = .ScaleAspectFit
        let numberImage = image.count
        myImage.image = image[numberImage - 1]
    }
    
    
    override func viewDidAppear(animated: Bool){
        displayinfo()
        runimageloader()
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
        picker.delegate = self
        if (image.count > 0) {
            self.myImage.layer.cornerRadius = self.myImage.frame.size.width / 2;
            self.myImage.clipsToBounds = true;
            self.myImage.layer.borderWidth = 3.0;
            let color = UIColor.grayColor().CGColor
            let backgound = UIColor.blackColor();
            self.myImage.layer.borderColor = color;
            self.myImage.backgroundColor = backgound;        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}