
Pod::Spec.new do |s|

s.name         = "SHMDatabase"
s.version      = "1.0.0"
s.summary      = "iOS石墨数据库组件"
s.homepage     = "https://github.com/shimohq/SHMDatabase"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "xietianchen" => "akateason@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/shimohq/SHMDatabase", :tag => s.version }

s.source_files  = "SHMDatabase/SHMDatabase/*.{h,m}"

s.public_header_files = "SHMDatabase/SHMDatabase/*.h"

s.dependency "YYModel"
s.dependency "FMDB"

end
