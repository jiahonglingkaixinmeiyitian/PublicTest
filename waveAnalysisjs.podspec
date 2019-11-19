

Pod::Spec.new do |s|
s.name = 'waveAnalysisjs'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'An Animate Water view on iOS.'
s.homepage = 'https://github.com/jiahonglingkaixinmeiyitian/waveAnalysisjs'
s.authors = { 'jiahongling' => 'm15116996950@163.com' }
s.source = { :git => 'https://github.com/jiahonglingkaixinmeiyitian/waveAnalysisjs.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'waveAnalysisjs/*.{h,m}'
#s.resources = 'SXWaveAnimate/images/*.{png,xib}'
end
