//
//  Sequencer.swift
//  EternalTriangle
//
//  Created by hokada on 9/13/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

import Foundation

public class Sequencer {
  private let sequencer = PrivateSequencer()

  public init() {

  }

  public func play() {
    sequencer.play()
  }

  public func stop() {
    sequencer.stop()
  }

  public func loadTune(tune: Tune) {
    var voices: [MIDIVoice] = []
    for (index, voice) in enumerate(tune.tuneBody.voices) {
      let header = tune.tuneHeader.voiceHeaders[index]

      var notes: [MIDINote] = []
      var timestamp: MusicTimeStamp = 0
      for elem in voice.elements {
        switch elem {
        case let n as Note:
          let note = pitchToMIDINote(n.pitch)
          let duration = 0.5 * Double(n.length.numerator) / Double(n.length.denominator)
          let message = MIDINoteMessage(channel: 0, note: note, velocity: 64, releaseVelocity: 0, duration: Float32(duration))

          notes.append(MIDINote(message: message, timestamp: timestamp))

          timestamp += duration
        default: ()
        }
      }

      voices.append(MIDIVoice(notes: notes as [AnyObject]))
    }
//
//    var voices: [MIDIVoice] = []
//
//    for j in 0..<5 {
//      var notes: [MIDINote] = []
//
//      for i in 0..<5 {
//        let message = MIDINoteMessage(channel: 0, note: UInt8(60 + j * 3 + i), velocity: 64, releaseVelocity: 0, duration: 0.5)
//        notes.append(MIDINote(message: message, timestamp: MusicTimeStamp(Double(i) / 2)))
//      }
//
//      voices.append(MIDIVoice(notes: notes as [AnyObject]))
//    }

    sequencer.loadVoices(voices as [AnyObject])
  }
}