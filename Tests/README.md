# SwiftMIDIIO Tests

> [!NOTE]
>
> Because unit tests interact with CoreMIDI services in the system (ie: create MIDI endpoints), tests must be run serially (non-parallel).
>
> This is accomplished by running the tests using `xcodebuild test` with the pre-configured Xcode scheme which uses a TestPlan set up to run all tests sequentially.