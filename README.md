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

    ipa_analyzer -i /path/to/app.ipa -p --info-plist --prov --entitlements --frameworks --appex --watch

This will collect and print:
* the embedded mobileprovisioning,
* the Info.plist, 
* the entitlements (from the Entitlements.plist or archived-expanded-entitlements.xcent files) if any,
* the list of frameworks and their Info.plist if any
* the Info.plist and embedded mobileprovisioning for the embedded Watch app if any
* the Info.plist and embedded mobileprovisioning for the app extensions if any
in a pretty printed JSON output.

NOTE: You can also use the shorthand '--all' which automatically includes all switches.

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
      },
      "app_extensions": [
        {
          "path_in_ipa": "Payload/MyApp.app/PlugIns/AppEx1.appex/",
          "mobileprovision": {
            "AppIDName": "AppEx1",
            "ApplicationIdentifierPrefix": [
              "XXXA8V3XXX"
            ],
            "CreationDate": "2017-01-31T18:02:00+00:00",
            "Platform": [
              "iOS"
            ],
            "Entitlements": {
              "keychain-access-groups": [
                "XXXA8V3XXX.*"
              ],
              "get-task-allow": false,
              "application-identifier": "XXXA8V3XXX.com.company.MyApp.AppEx1",
              "com.apple.developer.team-identifier": "XXXA8V3XXX"
            },
            "ExpirationDate": "2018-01-31T18:02:00+00:00",
            "Name": "com.company.MyApp.AppEx1 PP",
            "ProvisionsAllDevices": "true",
            "TeamIdentifier": [
              "XXXA8V3XXX"
            ],
            "TeamName": "Company",
            "TimeToLive": "365",
            "UUID": "XXX-3D5D-4BCC-9288-XXX",
            "Version": "1"
          },
          "entitlements": {
            "application-identifier": "XXXA8V3XXX.com.company.MyApp.AppEx1",
            "keychain-access-groups": [
              "XXXA8V3XXX.com.company.MyApp.AppEx1"
            ]
          },
          "info_plist": {
            "BuildMachineOSBuild": "16A323",
            "CFBundleDevelopmentRegion": "en",
            "CFBundleDisplayName": "AppEx1",
            "CFBundleExecutable": "AppEx1",
            "CFBundleIdentifier": "com.company.MyApp.AppEx1",
            "CFBundleInfoDictionaryVersion": "6.0",
            "CFBundleName": "AppEx1",
            "CFBundlePackageType": "XPC!",
            "CFBundleShortVersionString": "1.0",
            "CFBundleSupportedPlatforms": [
              "iPhoneOS"
            ],
            "CFBundleVersion": "1",
            "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
            "DTPlatformBuild": "14B72",
            "DTPlatformName": "iphoneos",
            "DTPlatformVersion": "10.1",
            "DTSDKBuild": "14B72",
            "DTSDKName": "iphoneos10.1",
            "DTXcode": "0810",
            "DTXcodeBuild": "8B62",
            "MinimumOSVersion": "10.0",
            "NSExtension": {
              "NSExtensionAttributes": {
                "UNNotificationExtensionCategory": "com.company.yesno",
                "UNNotificationExtensionDefaultContentHidden": true,
                "UNNotificationExtensionInitialContentSizeRatio": 0.3
              },
              "NSExtensionMainStoryboard": "MainInterface",
              "NSExtensionPointIdentifier": "com.apple.usernotifications.content-extension"
            },
            "UIDeviceFamily": [
              1
            ]
          },
          "plugins": [

          ]
        },
        {
          "path_in_ipa": "Payload/MyApp.app/PlugIns/AppEx2.appex/",
          "mobileprovision": {
            "AppIDName": "AppEx2",
            "ApplicationIdentifierPrefix": [
              "XXXA8V3XXX"
            ],
            "CreationDate": "2017-01-31T18:01:00+00:00",
            "Platform": [
              "iOS"
            ],
            "Entitlements": {
              "keychain-access-groups": [
                "XXXA8V3XXX.*"
              ],
              "get-task-allow": false,
              "application-identifier": "XXXA8V3XXX.com.company.MyApp.AppEx2",
              "com.apple.security.application-groups": [
                "group.company.test"
              ],
              "com.apple.developer.team-identifier": "XXXA8V3XXX"
            },
            "ExpirationDate": "2018-01-31T18:01:00+00:00",
            "Name": "com.company.MyApp.AppEx2",
            "ProvisionsAllDevices": "true",
            "TeamIdentifier": [
              "XXXA8V3XXX"
            ],
            "TeamName": "Company",
            "TimeToLive": "365",
            "UUID": "XXX-3D5D-4BCC-9288-XXX",
            "Version": "1"
          },
          "entitlements": {
            "com.apple.security.application-groups": [
              "group.company.test"
            ]
          },
          "info_plist": {
            "BuildMachineOSBuild": "16A323",
            "CFBundleDevelopmentRegion": "en",
            "CFBundleDisplayName": "AppEx2",
            "CFBundleExecutable": "AppEx2",
            "CFBundleIdentifier": "com.company.MyApp.AppEx2",
            "CFBundleInfoDictionaryVersion": "6.0",
            "CFBundleName": "AppEx2",
            "CFBundlePackageType": "XPC!",
            "CFBundleShortVersionString": "1.0",
            "CFBundleSignature": "????",
            "CFBundleSupportedPlatforms": [
              "iPhoneOS"
            ],
            "CFBundleVersion": "1",
            "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
            "DTPlatformBuild": "14B72",
            "DTPlatformName": "iphoneos",
            "DTPlatformVersion": "10.1",
            "DTSDKBuild": "14B72",
            "DTSDKName": "iphoneos10.1",
            "DTXcode": "0810",
            "DTXcodeBuild": "8B62",
            "MinimumOSVersion": "10.0",
            "NSExtension": {
              "NSExtensionAttributes": {
                "IntentsRestrictedWhileLocked": [

                ],
                "IntentsSupported": [
                  "INGetRideStatusIntent",
                  "INListRideOptionsIntent",
                  "INRequestRideIntent"
                ]
              },
              "NSExtensionPointIdentifier": "com.apple.intents-service",
              "NSExtensionPrincipalClass": "AppEx2.IntentHandler"
            },
            "UIDeviceFamily": [
              1
            ]
          },
          "plugins": [

          ]
        },
        {
          "path_in_ipa": "Payload/MyApp.app/PlugIns/AppEx3.appex/",
          "mobileprovision": {
            "AppIDName": "AppEx3",
            "ApplicationIdentifierPrefix": [
              "XXXA8V3XXX"
            ],
            "CreationDate": "2017-01-31T18:01:10+00:00",
            "Platform": [
              "iOS"
            ],
            "Entitlements": {
              "keychain-access-groups": [
                "XXXA8V3XXX.*"
              ],
              "get-task-allow": false,
              "application-identifier": "XXXA8V3XXX.com.company.MyApp.AppEx3",
              "com.apple.security.application-groups": [
                "group.company.test"
              ],
              "com.apple.developer.team-identifier": "XXXA8V3XXX"
            },
            "ExpirationDate": "2018-01-31T18:01:10+00:00",
            "Name": "AppEx3",
            "ProvisionsAllDevices": "true",
            "TeamIdentifier": [
              "XXXA8V3XXX"
            ],
            "TeamName": "Company",
            "TimeToLive": "365",
            "UUID": "XXX-3D5D-4BCC-9288-XXX",
            "Version": "1"
          },
          "entitlements": {
            "com.apple.security.application-groups": [
              "group.company.test"
            ]
          },
          "info_plist": {
            "BuildMachineOSBuild": "16A323",
            "CFBundleDevelopmentRegion": "en",
            "CFBundleDisplayName": "AppEx3",
            "CFBundleExecutable": "AppEx3",
            "CFBundleIdentifier": "com.company.MyApp.AppEx3",
            "CFBundleInfoDictionaryVersion": "6.0",
            "CFBundleName": "AppEx3",
            "CFBundlePackageType": "XPC!",
            "CFBundleShortVersionString": "1.0",
            "CFBundleSignature": "????",
            "CFBundleSupportedPlatforms": [
              "iPhoneOS"
            ],
            "CFBundleVersion": "1",
            "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
            "DTPlatformBuild": "14B72",
            "DTPlatformName": "iphoneos",
            "DTPlatformVersion": "10.1",
            "DTSDKBuild": "14B72",
            "DTSDKName": "iphoneos10.1",
            "DTXcode": "0810",
            "DTXcodeBuild": "8B62",
            "MinimumOSVersion": "10.0",
            "NSExtension": {
              "NSExtensionAttributes": {
                "IntentsSupported": [
                  "INListRideOptionsIntent",
                  "INRequestRideIntent",
                  "INGetRideStatusIntent"
                ]
              },
              "NSExtensionMainStoryboard": "MainInterface",
              "NSExtensionPointIdentifier": "com.apple.intents-ui-service"
            },
            "UIDeviceFamily": [
              1
            ]
          },
          "plugins": [

          ]
        }
      ],
      "watch": {
        "path_in_ipa": "Payload/MyApp.app/Watch/MyApp WatchKit App.app/",
        "mobileprovision": {
          "AppIDName": "WTBeta",
          "ApplicationIdentifierPrefix": [
            "XXXA8V3XXX"
          ],
          "CreationDate": "2017-01-31T15:31:24+00:00",
          "Platform": [
            "iOS"
          ],
          "Entitlements": {
            "keychain-access-groups": [
              "XXXA8V3XXX.*"
            ],
            "get-task-allow": true,
            "application-identifier": "XXXA8V3XXX.*",
            "com.apple.developer.ubiquity-kvstore-identifier": "XXXA8V3XXX.*",
            "com.apple.developer.icloud-services": "*",
            "com.apple.developer.icloud-container-environment": [
              "Development",
              "Production"
            ],
            "com.apple.developer.icloud-container-identifiers": [

            ],
            "com.apple.developer.icloud-container-development-container-identifiers": [

            ],
            "com.apple.developer.ubiquity-container-identifiers": [

            ],
            "com.apple.developer.team-identifier": "XXXA8V3XXX",
            "aps-environment": "development"
          },
          "ExpirationDate": "2018-01-31T15:31:24+00:00",
          "Name": "iOS Team Provisioning Profile: *",
          "ProvisionedDevices": [
            "XXX9F698E6E7753EF90B71485ADDC701F37DAXXX",
            "XXXEA28BF2DDF3A35BEB9A4E72231AD5B9104XXX",
            "XXXE65C5CADAFF06B56164787B21CBD7AD5B8XXX"
          ],
          "TeamIdentifier": [
            "XXXA8V3XXX"
          ],
          "TeamName": "Company",
          "TimeToLive": "365",
          "UUID": "bb710fd2-23fd-4c59-9264-4e52125dad02",
          "Version": "1"
        },
        "entitlements": {
          "application-identifier": "XXXA8V3XXX.com.company.application.iphone.watch-app",
          "keychain-access-groups": [
            "XXXA8V3XXX.com.company.application.iphone.watch-app"
          ]
        },
        "info_plist": {
          "BuildMachineOSBuild": "15G1004",
          "CFBundleDevelopmentRegion": "en",
          "CFBundleDisplayName": "MyApp",
          "CFBundleExecutable": "MyApp WatchKit App",
          "CFBundleIcons": {
            "CFBundlePrimaryIcon": {
              "CFBundleIconFiles": [
                "AppIcon24x24",
                "AppIcon27.5x27.5",
                "AppIcon29x29",
                "AppIcon40x40",
                "AppIcon86x86",
                "AppIcon98x98"
              ]
            }
          },
          "CFBundleIdentifier": "com.company.application.iphone.watch-app",
          "CFBundleInfoDictionaryVersion": "6.0",
          "CFBundleName": "MyApp WatchKit App",
          "CFBundlePackageType": "APPL",
          "CFBundleShortVersionString": "3.4.1",
          "CFBundleSignature": "????",
          "CFBundleSupportedPlatforms": [
            "WatchOS"
          ],
          "CFBundleVersion": "2016121201-debug",
          "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
          "DTPlatformBuild": "13S660",
          "DTPlatformName": "watchos",
          "DTPlatformVersion": "2.1",
          "DTSDKBuild": "13S660",
          "DTSDKName": "watchos2.1",
          "DTXcode": "0721",
          "DTXcodeBuild": "7C1002",
          "MinimumOSVersion": "2.0",
          "UIDeviceFamily": [
            4
          ],
          "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown"
          ],
          "WKCompanionAppBundleIdentifier": "com.company.application.iphone",
          "WKWatchKitApp": "true"
        },
        "plugins": [
          {
            "path_in_ipa": "Payload/MyApp.app/Watch/MyApp WatchKit App.app/PlugIns/MyApp WatchKit App Extension.appex/",
            "mobileprovision": {
              "AppIDName": "WTBeta",
              "ApplicationIdentifierPrefix": [
                "XXXA8V3XXX"
              ],
              "CreationDate": "2017-01-31T15:31:24+00:00",
              "Platform": [
                "iOS"
              ],
              "Entitlements": {
                "keychain-access-groups": [
                  "XXXA8V3XXX.*"
                ],
                "get-task-allow": true,
                "application-identifier": "XXXA8V3XXX.*",
                "com.apple.developer.ubiquity-kvstore-identifier": "XXXA8V3XXX.*",
                "com.apple.developer.icloud-services": "*",
                "com.apple.developer.icloud-container-environment": [
                  "Development",
                  "Production"
                ],
                "com.apple.developer.icloud-container-identifiers": [

                ],
                "com.apple.developer.icloud-container-development-container-identifiers": [

                ],
                "com.apple.developer.ubiquity-container-identifiers": [

                ],
                "com.apple.developer.team-identifier": "XXXA8V3XXX",
                "aps-environment": "development"
              },
              "ExpirationDate": "2018-01-31T15:31:24+00:00",
              "Name": "iOS Team Provisioning Profile: *",
              "ProvisionedDevices": [
                "XXX9F698E6E7753EF90B71485ADDC701F37DAXXX",
                "XXXEA28BF2DDF3A35BEB9A4E72231AD5B9104XXX",
                "XXXE65C5CADAFF06B56164787B21CBD7AD5B8XXX"
              ],
              "TeamIdentifier": [
                "XXXA8V3XXX"
              ],
              "TeamName": "Company",
              "TimeToLive": "365",
              "UUID": "bb710fd2-23fd-4c59-9264-4e52125dad02",
              "Version": "1"
            },
            "entitlements": {
              "application-identifier": "XXXA8V3XXX.com.company.application.iphone.watch-app.watch-extension",
              "keychain-access-groups": [
                "XXXA8V3XXX.com.company.application.iphone.watch-app.watch-extension"
              ]
            },
            "info_plist": {
              "BuildMachineOSBuild": "15G1004",
              "CFBundleDevelopmentRegion": "en",
              "CFBundleDisplayName": "MyApp WatchKit App Extension",
              "CFBundleExecutable": "MyApp WatchKit App Extension",
              "CFBundleIdentifier": "com.company.application.iphone.watch-app.watch-extension",
              "CFBundleInfoDictionaryVersion": "6.0",
              "CFBundleName": "MyApp WatchKit App Extension",
              "CFBundlePackageType": "XPC!",
              "CFBundleShortVersionString": "3.4.1",
              "CFBundleSignature": "????",
              "CFBundleSupportedPlatforms": [
                "WatchOS"
              ],
              "CFBundleVersion": "2016121201-debug",
              "DTCompiler": "com.apple.compilers.llvm.clang.1_0",
              "DTPlatformBuild": "13S660",
              "DTPlatformName": "watchos",
              "DTPlatformVersion": "2.1",
              "DTSDKBuild": "13S660",
              "DTSDKName": "watchos2.1",
              "DTXcode": "0721",
              "DTXcodeBuild": "7C1002",
              "MinimumOSVersion": "2.0",
              "NSExtension": {
                "NSExtensionAttributes": {
                  "WKAppBundleIdentifier": "com.company.application.iphone.watch-app"
                },
                "NSExtensionPointIdentifier": "com.apple.watchkit"
              },
              "RemoteInterfacePrincipalClass": "MyAppMainInferfaceController",
              "UIDeviceFamily": [
                4
              ],
              "WKExtensionDelegateClassName": "ExtensionDelegate"
            },
            "plugins": [

            ]
          }
        ]
      }
    }


## Requirements

* OS: OS X (tested on 10.10 Yosemite)
