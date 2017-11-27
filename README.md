# Reapal

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/reapal`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reapal'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reapal

## Usage

TODO: Write usage instructions here

### logger

``` ruby
Reapal.logger = Logger.new('reapal.log')
Reapal.logger # => #<Logger:0x007fa1f28b83f0>
```

* Note: If Reapal is being used within a Rails application, Reapal's logger is set to Rails.logger by default. *

## 开发

### 怎么加入

```
# 先 fork 此项目
# checkout 自己的项目后操作：
$ git remote -v # 查看主机源，如果只有自己的 origin 那还没有设置 upstream
$ git remote add upstream https://github.com/omniaccountcorp/reapal
$ git fetch upstream
$ git checkout master
$ git merge --no-ff upstream/master
# 如果有冲突解决...
$ git add 修改的文件
$ git commit -m 'merge from origin-git'
$ git push origin [自己开发的分支]
```

### 开发新 api 指南
1. 根据 service 名字，确定好 module ，新 api 文件名，方法名，比如：
    ``` ruby
    # 假如服务名: reapal.trust.mobileModify
    # 文件名：lib/reapal/api/trust/mobile_modify.rb
    module Reapal
      module Api
        module MobileModify
          def mobile_modify(...)
             # ...
          end
        end
      end
    end
    
    ```
2. 新 api 文件中写好注释（记得标明是文档中的哪一节），确定好函数输入输出
3. 写 spec
4. 实现 api
5. 测试通过后向作者提交 spec

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

**建议**
1. 使用 [fasterer](https://github.com/DamirSvrtan/fasterer) 来优化写的代码，怎么修改可以查看[这里](https://github.com/JuanitoFatas/fast-ruby)
2. 使用 [rubycritic](https://github.com/whitesmith/rubycritic) 来检测代码质量

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/reapal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Reapal project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/reapal/blob/master/CODE_OF_CONDUCT.md).
