// VolumeManager.swift
//
// Created by TeChris on 18.05.21.

import Foundation

class VolumeManager {
	var speakerVolume: Int {
		executeAppleScript("output volume of (get volume settings)")
		return Int(processOutput) ?? 0
	}
	
	var inputVolume: Int {
		executeAppleScript("input volume of (get volume settings)")
		return Int(processOutput) ?? 0
	}
	
	var isMuted: Bool {
		inputVolume == 0 && speakerVolume == 0
	}
	
	var originalVolume: Int?
	
	func mute() {
		originalVolume = speakerVolume
		setSpeakerVolume(to: 0)
		setInputVolume(to: 0)
	}
	
	func unmute() {
		setSpeakerVolume(to: originalVolume!)
		setInputVolume(to: 100)
	}
	
	private func setSpeakerVolume(to volume: Int) {
		executeAppleScript("set volume output volume \(volume)")
	}
	
	private func setInputVolume(to volume: Int) {
		executeAppleScript("set volume input volume \(volume)")
	}
	
	private var processOutput = ""
	
	private func executeAppleScript(_ script: String) {
		// Reset the output.
		processOutput = ""
		
		// Setup the Process.
		let process = Process()
		process.launchPath = "/usr/bin/osascript"
		process.arguments = ["-e", "\(script)"]
		
		// Setup the output.
		let pipe = Pipe()
		process.standardOutput = pipe
		
		process.launch()
		
		// Get the output.
		let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
		processOutput = String(data: outputData, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "") ?? ""
	}
}
