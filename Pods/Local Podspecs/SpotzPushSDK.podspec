Pod::Spec.new do |s|
	s.name	= 'SpotzPushSDK'
	s.platform = :ios,'7.0'
	s.license = 'Commercial License'
	s.version = '1.0.0.0'
	s.summary = 'SpotzPushSDK'
	s.homepage = 'http://www.localz.co'
	s.author = { 'Melvin Artemas' => 'ma@localz.co' }
	s.requires_arc = true
	s.ios.deployment_target = '7.0'
	s.source_files  = 'SpotzPushSDK', 'SpotzPushSDK/**/*.{h,m}'
	s.public_header_files = 'SpotzPushSDK/**/*.h'
#	s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited)' }
#	s.preserve_paths = 'SpotzPushSDK.framework'
# 	s.vendored_frameworks = 'SpotzPushSDK.framework'
	s.frameworks = 'CoreLocation'
end
