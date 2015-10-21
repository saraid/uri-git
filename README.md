Made this because I needed a standardized way to parse Git URIs and one wasn't available.

# Usage

```ruby
require 'uri/git'
#=> true
uri = URI::Git.parse('git@github.com:saraid/uri-git.git')
#=> #<URI::Git:0x007f9cc88e3728 URL:git://git@github.com>
uri.host
#=> "github.com"
uri.repo
#=> "saraid/uri-git.git"
uri.to_remote_str
#=> "git@github.com:saraid/uri-git.git"

uri = URI::Git.parse('http://www.google.com')
#=> #<URI::HTTP:0x007f9cc8a7bef0 URL:http://www.google.com>
```
