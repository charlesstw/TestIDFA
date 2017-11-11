//
//  ViewController.swift
//  WhatsMyIDFA
//
//  Created by Charles on 2017/11/10.
//  Copyright © 2017年 Charlesstw. All rights reserved.
//

import UIKit
import AdSupport

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idfaLabel: UILabel!
    @IBOutlet weak var osVersionLabel: UILabel!
    @IBOutlet weak var CopyButton: UIButton!
    
    
    private var osVersion:String?
    private var idfa:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDeviceInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(getDeviceInfo), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getDeviceInfo() {
        osVersion = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        if (ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            idfa = "You are not allow Ad tracking"
        }
        if (!ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            self.titleLabel.text = "Oops.."
            self.CopyButton.setTitle("Setting", for: UIControlState.normal)
        } else {
            self.titleLabel.text = "Your IDFA is"
            self.CopyButton.setTitle("Copy", for: UIControlState.normal)
        }
        self.osVersionLabel.text = self.osVersion!
        self.idfaLabel.text = idfa!
        
    }
    
    func setupUI() {
        self.CopyButton.layer.cornerRadius = self.CopyButton.frame.width/2
        self.CopyButton.layer.masksToBounds = true
    }
    
    func copyToPasteBoard() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = self.idfa
        SVProgressHUD.setMinimumDismissTimeInterval(0.1)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.showSuccess(withStatus: "Copied to pasteboard")
    }
    func goSetting() {
        
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        if (ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            self.copyToPasteBoard()
        } else {
            var settingUrl =  URL(string: "App-Prefs:root=Privacy&path=ADVERTISING")
            if (UIApplication.shared.canOpenURL(settingUrl!)){
                
            } else {
                settingUrl = URL(string: UIApplicationOpenSettingsURLString)!
            }
            UIApplication.shared.openURL(settingUrl!)
        }
    }
}

