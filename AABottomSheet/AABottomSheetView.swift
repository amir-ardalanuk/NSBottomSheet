//
//  AABottomSheetView.swift
//  AABottomSheet
//
//  Created by Amir Ardalan on 1/15/19.
//  Copyright © 2019 golrang. All rights reserved.
//

import Foundation
import UIKit
class AABottomSheetView : UIView , Connectable {
    
    var parent : UIViewController!
    var target : UIView!
    var collapseTrigger : (() -> Void)?
    
    enum CardState {
        case expanded
        case collapsed
    }
    var visualEffectView : UIVisualEffectView!
    var cardHeight : CGFloat = 200
    var cardHandelAreaHeight : CGFloat = 60
    
    var cardVisible = false
    var nextStep : CardState {
        return self.cardVisible ? .collapsed : .expanded
    }
    var runningAnimation = [UIViewPropertyAnimator]()
    var animationProgressWhenIntrupt : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(parent : UIViewController , target : UIView , collapseTrigger : (()-> Void)?){
        if let bottomSheetCustom = target as? BottomSheetCustomView {
            self.cardHeight = bottomSheetCustom.BottomSheetHeight
        }
        self.backgroundColor = .clear
        self.parent = parent
        self.target = target
        self.frame = parent.view.frame
        self.collapseTrigger = collapseTrigger ?? {
            self.removeFromSuperview()
        }
        setupCard()
    }
    
    func updateState(state : CardState){
        self.animationTransitionIfNeeded(state: state, duration: 0.5)
    }
    
    func setupCard(){
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.parent.view.frame
        self.addSubview(visualEffectView)
        
        self.parent.view.addSubview(self)
     
        target.frame = CGRect(x: 0, y: self.frame.height - cardHandelAreaHeight, width: self.frame.width, height: cardHeight)
        self.addSubview(target)
    
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handelPan(gesture:)))
        self.addGestureRecognizer(gesture)
        
    }
    
    @objc
    func handelPan(gesture : UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            startInteractiveTransition(state: nextStep, duration: 0.9)
        case .changed:
            let transition  = gesture.translation(in: self.parent.view)
            var franction = transition.y / self.cardHeight
            franction = self.cardVisible ? franction : -franction
            self.updateInteractiveTransition(fractionComplete: franction)
        case .ended:
            self.continueInteractiveTransition()
        default:break
        }
    }
    
    func animationTransitionIfNeeded(state : CardState , duration : TimeInterval) {
        if runningAnimation.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .collapsed:
                    self.target.frame.origin.y = self.frame.height - self.cardHandelAreaHeight
                    //self.frame.origin.y = self.target.frame.height - self.cardHandelAreaHeight
                case .expanded:
                    self.target.frame.origin.y = self.frame.height - self.cardHeight
                    //self.frame.origin.y = self.target.frame.height - self.cardHeight
                }
            }
            frameAnimator.addCompletion { (_) in
                self.cardVisible = !self.cardVisible
                self.runningAnimation.removeAll()
                
                if !self.cardVisible {
                    self.collapseTrigger?()
                }
            }
            frameAnimator.startAnimation()
            runningAnimation.append(frameAnimator)
            
            let bluerAnimating = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                    
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            bluerAnimating.startAnimation()
            runningAnimation.append(bluerAnimating)
        }
    }
    func startInteractiveTransition(state : CardState , duration : TimeInterval){
        if runningAnimation.isEmpty {
            animationTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimation {
            animator.pauseAnimation()
            animationProgressWhenIntrupt = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionComplete : CGFloat){
        for animator in runningAnimation {
            animator.fractionComplete = fractionComplete + self.animationProgressWhenIntrupt
        }
        
    }
    
    func continueInteractiveTransition(){
        for animator in runningAnimation {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
        
        
    }
}
class BottomSheetCustomView : UIView {
    @IBInspectable var BottomSheetHeight : CGFloat = 0.0
}
