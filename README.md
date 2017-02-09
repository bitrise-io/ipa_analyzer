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

    ipa_analyzer -i /path/to/app.ipa -p --info-plist --prov --entitlements --frameworks

This will collect and print:
* the embedded mobileprovisioning,
* the Info.plist, 
* the entitlements (from the Entitlements.plist or archived-expanded-entitlements.xcent files) if any,
* the list of frameworks if any
in a pretty printed JSON output.

The output of this command looks like this:

    {
      "mobileprovision": {
        "path_in_ipa": "Payload/MyApp.app/embedded.mobileprovision",
        "content": {
          "AppIDName": "Xcode iOS Wildcard App ID",
          "ApplicationIdentifierPrefix": [
            "XXXA8V3XXX"
          ],
          "CreationDate": "2014-05-10T11:57:32+00:00",
          "Entitlements": {
            "application-identifier": "XXXA8V3XXX.*",
            "get-task-allow": true,
            "keychain-access-groups": [
              "XXXA8V3XXX.*"
            ]
          },
          "ExpirationDate": "2015-05-10T11:57:32+00:00",
          "Name": "ProfileName",
          "ProvisionedDevices": [
            "xxx49cbdf9ad932exxx",
            "xxx968f2842d3601xxx",
            "xxxedb81abefddfbxxx",
            "xxx80001152f6f44xxx",
            "xxxe3b76df6e99d0xxx"
          ],
          "TeamIdentifier": [
            "XXXA8V3XXX"
          ],
          "TeamName": "Team Name",
          "TimeToLive": "365",
          "UUID": "XXX-3D5D-4BCC-9288-XXX",
          "Version": "1"
        }
      },
      "info_plist": {
        "path_in_ipa": "Payload/MyApp.app/Info.plist",
        "content": {
          "BuildMachineOSBuild": "14B25",
          "CFBundleDevelopmentRegion": "en",
          "CFBundleExecutable": "MyApp",
          "CFBundleIdentifier": "com.company.MyApp",
          "CFBundleInfoDictionaryVersion": "6.0",
          "CFBundleName": "MyApp",
          "CFBundlePackageType": "APPL",
          "CFBundleShortVersionString": "1.0",
          "CFBundleSignature": "????",
          "CFBundleSupportedPlatforms": [
            "iPhoneOS"
          ],
          "CFBundleVersion": "1",
          "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
          "DTPlatformBuild": "12B411",
          "DTPlatformName": "iphoneos",
          "DTPlatformVersion": "8.1",
          "DTSDKBuild": "12B411",
          "DTSDKName": "iphoneos8.1",
          "DTXcode": "0611",
          "DTXcodeBuild": "6A2008a",
          "LSRequiresIPhoneOS": "true",
          "MinimumOSVersion": "8.1",
          "UIDeviceFamily": [
            1,
            2
          ],
          "UILaunchStoryboardName": "LaunchScreen",
          "UIMainStoryboardFile": "Main",
          "UIRequiredDeviceCapabilities": [
            "armv7"
          ],
          "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationLandscapeLeft",
            "UIInterfaceOrientationLandscapeRight"
          ],
          "UISupportedInterfaceOrientations~ipad": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown",
            "UIInterfaceOrientationLandscapeLeft",
            "UIInterfaceOrientationLandscapeRight"
          ]
        }
      },
      "frameworks": {
        "path_in_ipa": "Payload/MyApp.app/Frameworks",
        "content": [
          {
            "filename": "Payload/MyApp.app/Frameworks/PodExample1.framework/Info.plist",
            "content": {
              "BuildMachineOSBuild": "14F27",
              "CFBundleDevelopmentRegion": "en",
              "CFBundleExecutable": "PodExample1",
              "CFBundleIdentifier": "org.cocoapods.PodExample1",
              "CFBundleInfoDictionaryVersion": "6.0",
              "CFBundleName": "PodExample1",
              "CFBundlePackageType": "FMWK",
              "CFBundleShortVersionString": "3.1.2",
              "CFBundleSignature": "????",
              "CFBundleSupportedPlatforms": [
                "iPhoneOS"
              ],
              "CFBundleVersion": "1",
              "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
              "DTPlatformBuild": "13C75",
              "DTPlatformName": "iphoneos",
              "DTPlatformVersion": "9.2",
              "DTSDKBuild": "13C75",
              "DTSDKName": "iphoneos9.2",
              "DTXcode": "0720",
              "DTXcodeBuild": "7C68",
              "MinimumOSVersion": "9.0",
              "UIDeviceFamily": [
                1,
                2
              ]
            }
          },
          {
            "filename": "Payload/MyApp.app/Frameworks/PodExample2.framework/Info.plist",
            "content": {
              "BuildMachineOSBuild": "14F27",
              "CFBundleDevelopmentRegion": "en",
              "CFBundleExecutable": "PodExample2",
              "CFBundleIdentifier": "org.cocoapods.PodExample2",
              "CFBundleInfoDictionaryVersion": "6.0",
              "CFBundleName": "PodExample2",
              "CFBundlePackageType": "FMWK",
              "CFBundleShortVersionString": "2.3.2",
              "CFBundleSignature": "????",
              "CFBundleSupportedPlatforms": [
                "iPhoneOS"
              ],
              "CFBundleVersion": "1",
              "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
              "DTPlatformBuild": "13C75",
              "DTPlatformName": "iphoneos",
              "DTPlatformVersion": "9.2",
              "DTSDKBuild": "13C75",
              "DTSDKName": "iphoneos9.2",
              "DTXcode": "0720",
              "DTXcodeBuild": "7C68",
              "MinimumOSVersion": "9.0",
              "UIDeviceFamily": [
                1,
                2
              ]
            }
          }
        ]
      },
      "entitlements": {
        "path_in_ipa": "Payload/MyApp.app/Entitlements.plist",
        "content": {
          "application-identifier": "XXXA8V3XXX.com.company.MyApp",
          "keychain-access-groups": [
            "XXXA8V3XXX.com.company.MyApp"
          ]
        }
      }
    }


## Requirements

* OS: OS X (tested on 10.10 Yosemite)
