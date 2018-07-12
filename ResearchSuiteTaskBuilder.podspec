#
# Be sure to run `pod lib lint ResearchSuiteTaskBuilder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ResearchSuiteTaskBuilder'
  s.version          = '0.11.0'
  s.summary          = 'The ResearchSuite Task Builder is an easy and extensible way to create Tasks for ResearchKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Building cross-platform ResearchSuite applications is hard.
  The ResearchSuite Task Builder makes it easier!
                       DESC

  s.homepage         = 'https://github.com/cornelltech/ResearchSuiteTaskBuilder-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { "James Kizer, Cornell Tech Foundry" => "jdk288 at cornell dot edu" }
  s.source           = { :git => 'https://github.com/ResearchSuite/ResearchSuiteTaskBuilder-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ResearchSuiteTaskBuilder/Classes/**/*'

  # s.resource_bundles = {
  #   'ResearchSuiteTaskBuilder' => ['ResearchSuiteTaskBuilder/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Gloss', '~> 2.0'
  s.dependency 'ResearchKit', '~> 1.3'
end
