# frozen_string_literal: true

require_relative './../lib/ipa_analyzer/analyzer'

describe IpaAnalyzer::Analyzer do
  describe 'ipa analyzer' do
    ipa_path = './spec/fixtures/ios-simple-objc.ipa'
    analyzer = IpaAnalyzer::Analyzer.new(ipa_path)
    analyzer.open!

    it 'collects  provisioning infos' do
      infos = analyzer.collect_provision_info
      expect(infos).not_to eq(nil)

      expect(infos[:path_in_ipa]).to eq('Payload/ios-simple-objc.app/embedded.mobileprovision')

      content = infos[:content]
      expect(content).not_to eq(nil)

      expect(content['AppIDName']).to eq('Xcode iOS Wildcard App ID')
      expect(content['ApplicationIdentifierPrefix']).to eq(['72SA8V3WYL'])
      expect(content['CreationDate']).to eq('2017-02-17T09:33:57+00:00')
      expect(content['Platform']).to eq(['iOS'])
      expect(content['ExpirationDate']).to eq('2018-02-17T09:33:57+00:00')
      expect(content['Name']).to eq('BitriseBot-Wildcard')
      expect(content['ProvisionedDevices']).to eq(['21bbc342c380001152f6f44055d3e8b3f4229740'])
      expect(content['TeamIdentifier']).to eq(['72SA8V3WYL'])
      expect(content['TeamName']).to eq('BITFALL FEJLESZTO KORLATOLT FELELOSSEGU TARSASAG')
      expect(content['TimeToLive']).to eq('365')
      expect(content['UUID']).to eq('548cd560-c511-4540-8b6b-cbec4a22f49d')
      expect(content['Version']).to eq('1')

      entitlements = content['Entitlements']
      expect(entitlements).not_to eq(nil)

      expect(entitlements['keychain-access-groups']).to eq(['72SA8V3WYL.*'])
      expect(entitlements['get-task-allow']).to eq(true)
      expect(entitlements['application-identifier']).to eq('72SA8V3WYL.*')
      expect(entitlements['com.apple.developer.team-identifier']).to eq('72SA8V3WYL')
    end

    it 'collects info.plist infos' do
      infos = analyzer.collect_info_plist_info
      expect(infos).not_to eq(nil)

      expect(infos[:path_in_ipa]).to eq('Payload/ios-simple-objc.app/Info.plist')

      content = infos[:content]
      expect(content).not_to eq(nil)

      expect(content['BuildMachineOSBuild']).to eq('15G1004')
      expect(content['CFBundleDevelopmentRegion']).to eq('en')
      expect(content['CFBundleExecutable']).to eq('ios-simple-objc')
      expect(content['CFBundleIdentifier']).to eq('Bitrise.ios-simple-objc')
      expect(content['CFBundleInfoDictionaryVersion']).to eq('6.0')
      expect(content['CFBundleName']).to eq('ios-simple-objc')
      expect(content['CFBundlePackageType']).to eq('APPL')
      expect(content['CFBundleShortVersionString']).to eq('1.0')
      expect(content['CFBundleSignature']).to eq('????')
      expect(content['CFBundleSupportedPlatforms']).to eq(['iPhoneOS'])
      expect(content['CFBundleVersion']).to eq('1')
      expect(content['DTCompiler']).to eq('com.apple.compilers.llvm.clang.1_0')
      expect(content['DTPlatformBuild']).to eq('13E230')
      expect(content['DTPlatformName']).to eq('iphoneos')
      expect(content['DTPlatformVersion']).to eq('9.3')
      expect(content['DTSDKBuild']).to eq('13E230')
      expect(content['DTSDKName']).to eq('iphoneos9.3')
      expect(content['DTXcode']).to eq('0731')
      expect(content['DTXcodeBuild']).to eq('7D1014')
      expect(content['LSRequiresIPhoneOS']).to eq('true')
      expect(content['MinimumOSVersion']).to eq('8.1')
      expect(content['UIDeviceFamily']).to eq([1, 2])
      expect(content['UILaunchStoryboardName']).to eq('LaunchScreen')
      expect(content['UIMainStoryboardFile']).to eq('Main')
      expect(content['UIRequiredDeviceCapabilities']).to eq(['armv7'])
      expect(content['UISupportedInterfaceOrientations']).to eq(%w[UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight])
      expect(content['UISupportedInterfaceOrientations~ipad']).to eq(%w[UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight])
    end
  end
end
