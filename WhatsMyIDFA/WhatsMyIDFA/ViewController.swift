//
//  ViewController.swift
//  WhatsMyIDFA
//
//  Created by Charles on 2017/11/10.
//  Copyright © 2017年 Charlesstw. All rights reserved.
//

import UIKit
import AdSupport
import GoogleMobileAds

class ViewController: UIViewController,GADBannerViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idfaLabel: UILabel!
    @IBOutlet weak var osVersionLabel: UILabel!
    @IBOutlet weak var CopyButton: UIButton!
    
    private var osVersion:String?
    private var idfa:String?
    
    var bannerView: GADBannerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeviceInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(getDeviceInfo), name: UIApplication.didBecomeActiveNotification, object: nil)
        initBanner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func getDeviceInfo() {
        osVersion = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        if (ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            idfa = "You are limited Ad tracking"
        }
        if (!ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            self.titleLabel.text = "Oops.."
            self.CopyButton.setTitle("Setting", for: UIControl.State.normal)
        } else {
            self.titleLabel.text = "Your IDFA is"
            self.CopyButton.setTitle("Copy", for: UIControl.State.normal)
        }
        self.osVersionLabel.text = self.osVersion!
        self.idfaLabel.text = idfa!
        
    }
    
    func setupUI() {
        self.CopyButton.layer.cornerRadius = self.CopyButton.frame.width/2
        self.CopyButton.layer.masksToBounds = true
    }
    
    func initBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //test
//        bannerView.adUnitID = "ca-app-pub-7592415331992597/9323287140"
        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func copyToPasteBoard() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = self.idfa
        SVProgressHUD.setMinimumDismissTimeInterval(0.1)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        SVProgressHUD.showSuccess(withStatus: "Copied to pasteboard")
    }
    func goSetting() {
        var settingUrl =  URL(string: "App-Prefs:root=Privacy&path=ADVERTISING")
        if (UIApplication.shared.canOpenURL(settingUrl!)){
            
        } else {
            settingUrl = URL(string: UIApplication.openSettingsURLString)!
        }
        UIApplication.shared.openURL(settingUrl!)
    }
    
    // MARK:- AdMob delegate
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    // MARK: - Button Action
    @IBAction func copyButtonPressed(_ sender: Any) {
        if (ASIdentifierManager.shared().isAdvertisingTrackingEnabled) {
            copyToPasteBoard()
        } else {
            goSetting()
        }
    }
}

