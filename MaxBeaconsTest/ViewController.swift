//
//  ViewController.swift
//  MaxBeaconsTest
//
//  Created by Maxim Mikheev on 23/05/15.
//  Copyright (c) 2015 Maxim Mikheev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    let beaconManager = ESTBeaconManager()
//    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), major: 54155, minor: 38164, identifier: "KeyflowTest")
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "KeyflowTest")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        beaconManager.delegate = self
        
        beaconManager.requestAlwaysAuthorization()
        beaconManager.startMonitoringForRegion(beaconRegion)
        beaconManager.requestStateForRegion(beaconRegion)
    }
    
    func beaconManager(manager: AnyObject!, didDetermineState state: CLRegionState, forRegion region: CLBeaconRegion!) {
        if state == CLRegionState.Inside {
            println("We are inside the region")
            statusLabel.text = "Welcome to our venue!"
        } else {
            println("We are outside of the region")
            statusLabel.text = "Thanks for visiting us today!"
        }
    }
    
    func beaconManager(manager: AnyObject!, didEnterRegion region: CLBeaconRegion!) {
        println("We entered the region")
        showNotification("Welcome to our venue!")
    }
    
    func beaconManager(manager: AnyObject!, didExitRegion region: CLBeaconRegion!) {
        println("We exited the region")
        showNotification("Thanks for visiting us today!")
    }
    
    func beaconManager(manager: AnyObject!, monitoringDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        println("Error: \(error)")
    }
    
    func showNotification(alertBody: String) {
        var notification = UILocalNotification()
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }

}

