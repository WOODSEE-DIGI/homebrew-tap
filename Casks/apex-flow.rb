cask "apex-flow" do
  version "1.0,3"
  sha256 "51c704970c80800b84204e954654a9fc9a5048c2e6e08f75d3a82d964ae1592d"

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
