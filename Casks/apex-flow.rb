cask "apex-flow" do
  version "1.0,5"
  sha256 "f1c84869fae042d8f963dfedd45e3b6a9530042b3b6961a8f7b5fb2e868966de"

  url "https://github.com/WOODSEE-DIGI/ApexFlow/releases/download/v#{version.csv.first}/ApexFlow-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Apex Flow"
  desc "Native macOS system monitor with Thunderbolt, USB, MIDI and OSC monitoring"
  homepage "https://github.com/WOODSEE-DIGI/ApexFlow"

  livecheck do
    url :url
    regex(/ApexFlow[._-]v?(\d+(?:\.\d+)+)-(\d+)\.dmg/i)
    strategy :github_latest do |json, regex|
      match = json["assets"]&.map { |asset| asset["name"] }&.find { |name| name.match?(regex) }
      next if match.blank?

      match.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  app "ApexFlow.app"

  zap trash: [
    "~/Library/Preferences/com.woodsee-digi.ApexFlow.plist",
    "~/Library/Saved Application State/com.woodsee-digi.ApexFlow.savedState",
  ]

  caveats <<~EOS
    Apex Flow is signed with a Developer ID certificate and notarized by Apple.
    On first launch you may still see a Gatekeeper prompt because the app was
    downloaded from the internet; click "Open" to allow it.
  EOS
end
