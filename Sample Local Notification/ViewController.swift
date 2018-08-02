//
//  ViewController.swift
//  Sample Local Notification
//
//  Created by Rahmat Hidayat on 8/1/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        self.sendLocalNotif()
    }
    
    @available(iOS 10.0, *)
    func sendLocalNotif(){
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("error permission notification")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = self.txtTitle.text!
        content.body = self.txtBody.text!
        content.sound = UNNotificationSound.default()
        let imgUrl = Bundle.main.url(forResource: "ic_notif", withExtension:"png")!
        let attachement = try! UNNotificationAttachment(identifier: "image", url: imgUrl, options: nil)
        content.attachments = [ attachement ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

}

