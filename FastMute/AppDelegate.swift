// AppDelegate.swift
//
// Created by TeChris on 18.05.21.

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		if manager.isMuted {
			statusItem.button?.title = "􀊣􀊳"
		} else {
			statusItem.button?.title = "􀊡􀊱"
		}
		statusItem.button?.action = #selector(buttonAction)
	}
	
	let manager = VolumeManager()
	
	func applicationWillTerminate(_ aNotification: Notification) {
		manager.unmute()
	}
	
	@objc func buttonAction() {
		if manager.isMuted {
			manager.unmute()
			statusItem.button?.title = "􀊡􀊱"
		} else {
			manager.mute()
			statusItem.button?.title = "􀊣􀊳"
		}
	}
}

