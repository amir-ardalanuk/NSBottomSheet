//
//  ViewController1.swift
//  AABottomSheet
//
//  Created by Amir Ardalan on 12/30/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    lazy var bottomSheet : AABottomSheetView = {
        let vw = AABottomSheetView()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2")
        vw.cardHandelAreaHeight = 0.0
        let customView = CustomView()
        vw.config(parent: self, target: customView, collapseTrigger: nil)
        
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bottomSheet)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5) {
            self.bottomSheet.updateState(state: .expanded)
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func onCustomView(_ sender: Any) {
    self.showCustomView()
    }
    
    @IBAction func onVC(_ sender: Any) {
        self.showVC()
    }
    

    func showVC(){
        let vw = AABottomSheetView()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2")
        vw.cardHandelAreaHeight = 0.0

        vw.config(parent: self, target: vc.view, collapseTrigger: nil)
        vw.updateState(state: .expanded)
    }
    
    func showCustomView(){
        let vw = AABottomSheetView()
        vw.cardHandelAreaHeight = 0.0
        
        let customView = BottomSheetCustomView()
        customView.BottomSheetHeight = 220
        customView.layer.cornerRadius = 5
        customView.layer.shadowColor = UIColor.black.cgColor
        customView.layer.shadowOpacity = 0.3
        customView.layer.shadowOffset = CGSize(width: -1, height: -1)
        customView.backgroundColor = .green
        vw.config(parent: self, target: customView, collapseTrigger: nil)
        vw.updateState(state: .expanded)
    }

}
