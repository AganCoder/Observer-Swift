//
//  ObserverSet.swift
//  AlamofireSimpleDemo
//
//  Created by Enjoy on 2018/8/4.
//  Copyright © 2018 enjoy. All rights reserved.
//

import Foundation

class ObserverEntity<Parameters> {
    
    fileprivate weak var object: AnyObject?
    
    fileprivate let action: (Parameters) -> Void
    
    init(object: AnyObject, excution: @escaping (Parameters) -> Void) {
        self.object = object
        self.action = excution
    }
}

class ObserverSet <Parameters> {
    
    private let barrierQueue = DispatchQueue(label: "io.github.rsenjoyer.ObseverSet",  attributes: .concurrent)
    
    private var entities: [ObserverEntity<Parameters>] = []
    
    func add(_ object: AnyObject, excution work:@escaping (Parameters) -> Void) {
        
        let entity = ObserverEntity(object: object, excution: work)
        
        barrierQueue.sync(flags: DispatchWorkItemFlags.barrier) { entities.append(entity) }
    }
    
    func add(excution work:@escaping (Parameters) -> Void) {
        add(self, excution: work)
    }
    
    func notify(_ parameters: Parameters) {
        
        var toCall: [(Parameters) -> Void] = []
        
        barrierQueue.sync(flags: DispatchWorkItemFlags.barrier) {
            
            for entry in self.entities where entry.object != nil {
                toCall.append(entry.action)
            }
            self.entities = self.entities.filter { $0.object == nil }
        }
        toCall.forEach { $0(parameters) }
    }
}
