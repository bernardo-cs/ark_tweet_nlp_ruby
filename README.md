# ArkTweetNlp

Ruby wrapper for the [Carnegie Mellon Twitter NLP and Part-of-Speech Tagging](http://www.ark.cs.cmu.edu/TweetNLP/)
Not all features are implemented yet, check the examples to see how to use it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ark_tweet_nlp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ark_tweet_nlp

## Usage

See the list of supported tags:
```ruby
ArkTweetNlp::Parser::TAGSET
```

Tag a tweet text:
```ruby
tagged_result = ArkTweetNlp::Parser.find_tags('faceboooooooook is awesome')
#=> [ {'faceboooooooook' => :^,'is' => :V,'awesome' => :A }]
```

Or multiple tweets separated by \n:
```ruby
tagged_result = ArkTweetNlp::Parser.find_tags("faceboooooooook is awesome\nfaceboooooooook is awesome")
#=> [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A} ]
```

Get all words tagged as a specific tag:
```ruby
tagged_result = [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A}]
ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A,:V,:^)
#=>  {:^ => ["faceboooooooook"], :V => ["is"], :A => ["awesome"]}
```

Count all types of tags:
```ruby
tweets = "tweet 1\n tweet 2\n tweet 3\n"
tagged_result = ArkTweetNlp::Parser.find_tags( tweets )
tagged_result = ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, *ArkTweetNlp::Parser::TAGSET.keys)
tagged_result.each_pair do |k,v|
 puts("#{ArkTweetNlp::Parser::TAGSET[k]}\t#{Set.new(v).size}")
end
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/ark_tweet_nlp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
