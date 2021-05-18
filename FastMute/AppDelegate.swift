// AppDelegate.swift
//
// Created by TeChris on 18.05.21.

import Cocoa
import Carbon.HIToolbox.Events

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
		
		// Setup keyboard shortcuts.
		KeyboardShortcutManager(keyboardShortcut: KeyboardShortcut(key: Key(keyCode: UInt32(kVK_ANSI_M)), modifiers: [.control, .option], events: [.keyDown]))
			.startListeningForEvents { _ in
				self.buttonAction()
			}
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

