cask "apex-flow" do
  version "1.0,7"
  sha256 "093ba7e87ebc86e53725d50f16ca4eba07e0c9a4317b5ea2771d5ade9fb37a8e"

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
