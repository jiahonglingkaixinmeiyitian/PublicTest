
Pod::Spec.new do |s|
    s.name         = "waveAnalysisjs"
    s.version      = "4.0.0"
    s.ios.deployment_target = '7.0'
    s.summary      = "A delightful setting interface framework.kkkkkk"
    s.homepage     = "https://github.com/jiahonglingkaixinmeiyitian/waveAnalysisjs"
    s.license              = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "jiahongling" => "m15116996950@163.com" }
    s.social_media_url   = "https://www.jianshu.com/u/22a6ca7d9c40"
    s.source       = { :git => "https://github.com/jiahonglingkaixinmeiyitian/waveAnalysisjs.git", :tag => s.version }
    s.source_files  = "waveAnalysisjs/*.{h,m}"
    #s.resources          = "YJSettingTableView/YJSettingTableView.bundle"
    s.requires_arc = true
end
