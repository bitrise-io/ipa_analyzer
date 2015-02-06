# ipa_analyzer

iOS IPA file analyzer

**This code will be converted to a Ruby Gem
once the basic functionality is implemented**


## Usage example

    bundle exec ruby ipa_analyzer.rb -i /path/to/app.ipa -p --info-plist --prov

This will collect and print both the embedded mobileprovisioning
and the Info.plist, in a pretty printed JSON output.


## Requirements

* OS: OS X (tested on 10.10 Yosemite)
