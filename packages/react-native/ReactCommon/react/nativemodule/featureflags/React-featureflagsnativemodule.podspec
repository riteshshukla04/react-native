# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

require "json"

package = JSON.parse(File.read(File.join(__dir__, "..", "..", "..", "..", "package.json")))
version = package['version']

source = { :git => 'https://github.com/facebook/react-native.git' }
if version == '1000.0.0'
  # This is an unpublished version, use the latest commit hash of the react-native repo, which we’re presumably in.
  source[:commit] = `git rev-parse HEAD`.strip if system("git rev-parse --git-dir > /dev/null 2>&1")
else
  source[:tag] = "v#{version}"
end

header_search_paths = []

if ENV['USE_FRAMEWORKS']
  header_search_paths << "\"$(PODS_TARGET_SRCROOT)/../../..\"" # this is needed to allow the feature flags access its own files
end

Pod::Spec.new do |s|
  s.name                   = "React-featureflagsnativemodule"
  s.version                = version
  s.summary                = "React Native internal feature flags"
  s.homepage               = "https://reactnative.dev/"
  s.license                = package["license"]
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = min_supported_versions
  s.source                 = source
  s.source_files           = podspec_sources("*.{cpp,h}", "*.h")
  s.header_dir             = "react/nativemodule/featureflags"
  s.pod_target_xcconfig    = { "CLANG_CXX_LANGUAGE_STANDARD" => rct_cxx_language_standard(),
                               "HEADER_SEARCH_PATHS" => header_search_paths.join(' '),
                               "OTHER_CFLAGS" => "$(inherited)",
                               "DEFINES_MODULE" => "YES" }

  if ENV['USE_FRAMEWORKS']
    s.module_name            = "React_featureflagsnativemodule"
    s.header_mappings_dir  = "../.."
  end

  s.dependency "React-jsi"
  s.dependency "React-jsiexecutor"

  depend_on_js_engine(s)
  add_rn_third_party_dependencies(s)
  add_rncore_dependency(s)

  s.dependency "ReactCommon/turbomodule/core"
  s.dependency "React-RCTFBReactNativeSpec"
  s.dependency "React-featureflags"
end
