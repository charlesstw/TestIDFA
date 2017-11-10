//
//  ViewController.swift
//  WhatsMyIDFA
//
//  Created by Charles on 2017/11/10.
//  Copyright © 2017年 Charlesstw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idfaLabel: UILabel!
    @IBOutlet weak var osVersionLabel: UILabel!
    
    
    private var osVersion:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getDeviceInfo() {
        osVersion = UIDevice.current.systemName + UIDevice.current.systemVersion
        
    }
    
    func setupUI() {
        
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
    }
}

