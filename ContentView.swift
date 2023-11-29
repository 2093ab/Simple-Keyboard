import SwiftUI
import AudioKit
import Keyboard

class AudioMidi: ObservableObject {
    let midi = MIDI()
    let engine = AudioEngine()
    var instrument = AppleSampler()
    
    init() {
        engine.output = instrument
        try? engine.start()
    }

    func makeMidi() {
        midi.openOutput()
    }
    func destroyMidi() {
        midi.closeOutput()
    }
    
    func noteOn(pitch : Pitch, point : CGPoint) {
        midi.sendNoteOnMessage (noteNumber : MIDINoteNumber(pitch.intValue), velocity : 127)
        instrument.play(noteNumber: MIDINoteNumber(pitch.intValue), velocity: 127, channel: 0)
    }
    func noteOff(pitch : Pitch) {
        midi.sendNoteOffMessage(noteNumber: MIDINoteNumber(pitch.intValue))
        instrument.stop(noteNumber: MIDINoteNumber(pitch.intValue), channel: 0)
    }
}

struct SwiftUIKeyboard: View {
    var noteOn: (Pitch, CGPoint) -> Void = { _, _ in }
    var noteOff: (Pitch)->Void
    var startPitch: Int
    var endPitch: Int
    var body: some View {
        Keyboard(layout: .piano(pitchRange: Pitch(intValue: startPitch)...Pitch(intValue: endPitch)), noteOn: noteOn, noteOff: noteOff)
            .cornerRadius(5.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView: View {
    @StateObject var controller = AudioMidi()
    @State var startPitch : Int = 24
    @State var numOfKeys : Int = 24
    var body: some View {
        VStack {
            Stepper(value: $startPitch, in: 12...72) {
                Text("start: \(startPitch)")
            }
            Stepper(value: $numOfKeys, in: 12...36) {
                Text("keys: \(numOfKeys)")
            }
            SwiftUIKeyboard(noteOn: controller.noteOn(pitch: point:), noteOff: controller.noteOff, startPitch: startPitch, endPitch: startPitch + numOfKeys).padding(10)
        }
        .onAppear(perform: {
            controller.makeMidi()
        })
        .onDisappear(perform: {
            controller.destroyMidi()
        })
        .environmentObject(controller)
        .background(Color.black)
    }
}
