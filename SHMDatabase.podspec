
Pod::Spec.new do |s|

s.name         = "SHMDatabase"
s.version      = "0.0.1"
s.summary      = "iOS石墨数据库组件"
s.homepage     = "https://git.shimo.im/ios/SHMDatabase"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "xietianchen" => "xietianchen@shimo.im" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://git.shimo.im/ios/SHMDatabase", :tag => s.version }

s.source_files  = "SHMDatabase/SHMDatabase/*.{h,m}"

s.public_header_files = "SHMDatabase/SHMDatabase/*.h"

s.dependency "YYModel"
s.dependency "FMDB"

end
