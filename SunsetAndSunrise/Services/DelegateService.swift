//
//  DelegateService.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct DelegateService<Input> {
    
    private(set) var callback: ((Input) -> ())?
    
    mutating func delegate<Object: AnyObject>(to object: Object, with callback: @escaping(Object, Input) -> ()) {
        self.callback = { [weak object] input in
            guard let object = object else { return }
            callback(object, input)
        }
    }
    
}
