# ipa_analyzer

iOS IPA file analyzer.

Can be used directly in Ruby projects (it requires OS X as it's platform
to perform Plist file conversions!) or as a CLI in your Command Line / Terminal.


You can use this GEM by adding it to your Gemfile:

    gem 'ipa_analyzer'

Or install it as a system-wide GEM / CLI:

    gem install ipa_analyzer



## Usage example

If used as a CLI:

    ipa_analyzer -i /path/to/app.ipa -p --info-plist --prov

This will collect and print both the embedded mobileprovisioning
and the Info.plist, in a pretty printed JSON output.


## Requirements

* OS: OS X (tested on 10.10 Yosemite)
