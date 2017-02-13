Pod::Spec.new do |s|
s.name           = 'SwipyImageView'
s.version        = '0.1'
s.summary        = "Mini gallery."
s.homepage       = "https://github.com/VladasZ/SwipyImageView"
s.author         = { 'Vladas Zakrevskis' => '146100@gmail.com' }
s.source         = { :git => 'https://github.com/VladasZ/SwipyImageView.git', :tag => s.version }
s.ios.deployment_target = '9.0'
s.source_files   = 'Sources/*.swift'
s.source_files   = 'Sources/*.xib'
s.license        = 'MIT'
#s.dependency     'LazySwift', git: 'https://github.com/VladasZ/LazySwift.git'

end
