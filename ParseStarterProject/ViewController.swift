/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

var mailList = [String] ()
let list = mailList.count
class ViewController: UIViewController {
    
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var tittle2: UILabel!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signInn: UIButton!
    
    @IBAction func demoSkip(sender: AnyObject) {
        mailList.append("besseysimoo@hotmail.com")
    }
    
    @IBAction func signIn(sender: AnyObject) {
        let searchCharacter: Character = "@"
        let searchCharacterTwo: Character = "."
        let searchCharacterThree = ""
        let email = emailAddress.text
        let countingChars = email?.characters.count
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(email == (searchCharacterThree)){
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Invalid", message:"You must provide a valid email address", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true){}

            } else {
                // Fallback on earlier versions
            }
        }
        
        if (countingChars != 0) {
            
            if ((email!.characters.contains(searchCharacter))&&(email!.characters.contains(searchCharacterTwo))){
                
                mailList.append(emailAddress.text!)
                performSegueWithIdentifier("start", sender: self)
                defaults.setObject(emailAddress.text, forKey: "Email")
                defaults.synchronize()
                mailList[0] = defaults.objectForKey("Email") as! String
            }
                
            else if(email!.characters.contains(searchCharacterTwo) == false) {
                if(email == (searchCharacterThree)){
                    if #available(iOS 8.0, *) {
                        let alert = UIAlertController(title: "Invalid", message:"You must provide a valid email address", preferredStyle: .Alert)
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
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        backgroundImage.transform = CGAffineTransformMakeRotation(CGFloat(0.5 * (M_PI_4)))
        // Do any additional setup after loading the view, typically from a nib.
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
    func displayview() {
        if(mailList.count != 0){
            performSegueWithIdentifier("start", sender: self)
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        self.displayview()
    }
    
    
    //    override func viewDidLayoutSubviews() {
    //        setView()
    //    }
    
}
