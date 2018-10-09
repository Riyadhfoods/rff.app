//
//  main.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//


import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(TimerApplication.self),
    NSStringFromClass(AppDelegate.self)
)
