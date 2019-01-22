
//
//  ViewController2.swift
//  AABottomSheet
//
//  Created by Amir Ardalan on 12/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit


class ViewController2: UIViewController {
    var handelArea: UIView {
        get{
            return _handelArea
        }
    }
    
    var gesture: UIPanGestureRecognizer{
        set{
            _gesture = newValue
            self._handelArea.addGestureRecognizer(newValue)
        }
        get{
            return _gesture ?? UIPanGestureRecognizer()
        }
    }
    
    
    
    var _gesture : UIPanGestureRecognizer?
    
    func handelArea(gesture: UIPanGestureRecognizer) {
        self.gesture = gesture
    }
    
    func handelView() -> UIView? {
        return _handelArea
    }
    
     @IBOutlet weak var _handelArea : UIView!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ges = self._gesture {
            self._handelArea.addGestureRecognizer(_ges)
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
