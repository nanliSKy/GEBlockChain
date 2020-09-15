//
//  SignalProducerTest.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/4.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

func generateSignalProducer() {
    
    let signalProducerGenerator:(Int) -> SignalProducer<Int, Error> = { timeInterval in
        return SignalProducer<Int, Error> { (observer, lifetime) in
            let now = DispatchTime.now()
            for index in 0 ..< 10 {
                let timeElapsed = index * timeInterval
                DispatchQueue.main.asyncAfter(deadline: now + Double(timeElapsed)) {
                    guard !lifetime.hasEnded else {
                        observer.sendInterrupted()
                        return
                    }
                    observer.send(value: timeElapsed)
                    if index == 9 {
                        observer.sendCompleted()
                    }
                }
            }
        }
    }
    
    let signalProducer = signalProducerGenerator(1)
    let signalProducer2 = signalProducerGenerator(2)
    
    signalProducer.start { (value) in
        print("value from signalProducer = \(value)")
    }
    
    signalProducer2.start { (value) in
        print("value from signalProducer2 = \(value)")
    }
}


// MARK： action
func basicAction() {
    
    let signalProducerGenerator:(Int) -> SignalProducer<Int, Error> = { timeInterval in
        return SignalProducer<Int, Error> { (observer, lifetime) in
            let now = DispatchTime.now()
            for index in 0 ..< 10 {
                let timeElapsed = index + timeInterval
                DispatchQueue.main.asyncAfter(deadline: now + Double(timeElapsed)) {
                    guard !lifetime.hasEnded else {
                        observer.sendInterrupted()
                        return
                    }
                    
                    observer.send(value: timeElapsed)
                    if index == 9 {
                        observer.sendCompleted()
                    }
                }
            }
        }
    }
    
    //: # difine an action with a closuer
    let action = Action<Int, Int, Error>(execute: signalProducerGenerator)
    
    // observer values received
    action.values.observeValues { (value) in
        print("time elapsed = \(value)")
    }
    
    //: ### Observe when action completes
    action.values.observeCompleted {
        print("Action completed")
    }
    
    //: ### Apply the action with inputs and start it
    action.apply(1).start()
    
}

func textSignalGenerator(text: String) -> Signal<String, Never> {
    return Signal { (observer, _) in
        let now = DispatchTime.now()
        for index in 0 ..< text.count {
            DispatchQueue.main.asyncAfter(deadline: now + 1.0 * Double(index)) {
                let indexStartOfText = text.index(text.startIndex, offsetBy: 0)
                let indexEndOfText = text.index(text.startIndex, offsetBy: index)
                let subString = text[indexStartOfText ... indexEndOfText]
                let value = String(subString)
                observer.send(value: value)
            }
        }
        
    }
}

func lengthCheckerSignalProducer(text: String, minimumLength: Int) -> SignalProducer<Bool, Never> {
    return SignalProducer<Bool, Never> { (observer, _) in
        observer.send(value: text.count > minimumLength)
        observer.sendCompleted()
    }
}

