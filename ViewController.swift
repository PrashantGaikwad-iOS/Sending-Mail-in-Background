//
//  ViewController.swift
//  Sending Mail in Background
//
//  Created by Prashant G on 1/23/19.
//  Copyright © 2019 Prashant G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "fakeid@gmail.com"
        smtpSession.password = "fakePassword"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "", mailbox: "userid@gmail.com")]
        builder.header.from = MCOAddress(displayName: "LRM Support", mailbox: "fakeid0@gmail.com")
        builder.header.subject = "Test Email"
        builder.htmlBody="<p>Thank you for watching</p>"
        builder.addAttachment(MCOAttachment(contentsOfFile: "Prashant.pdf path"))
        
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
                
                
            } else {
                NSLog("Successfully sent email!")
                
                
            }
        }
        
    }
    
    
    
}

