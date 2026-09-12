# WOODSEE-DIGI Homebrew Tap

Personal Homebrew tap for WOODSEE-DIGI tools and applications.

## Usage

```bash
brew tap WOODSEE-DIGI/tap
```

## Available casks

| Cask | Description |
|---|---|
| `apex-flow` | Native macOS system monitor with Thunderbolt, USB, MIDI and OSC monitoring |

## Install Apex Flow

```bash
brew install --cask apex-flow
```

Because Apex Flow is ad-hoc signed, macOS may quarantine the app on first launch. Right-click the app and choose **Open**, or run:

```bash
xattr -dr com.apple.quarantine /Applications/ApexFlow.app
```
