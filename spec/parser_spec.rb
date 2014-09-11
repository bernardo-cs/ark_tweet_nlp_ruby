require_relative "../lib/ark_tweet_nlp/parser.rb"

describe ArkTweetNlp::Parser do
  describe 'TAGSET' do
    it "It has 25 different types of tags" do
      expect(ArkTweetNlp::Parser::TAGSET.size).to eq 25
    end
  end
  describe '#find_tags' do
    it "cathegorizes words in tweets" do
      expect(ArkTweetNlp::Parser.find_tags('faceboooooooook is awesome')).to eq([ {'faceboooooooook' => :^,
                                                                                 'is' => :V,
                                                                                 'awesome' => :A }])
    end
    it "tags multiple tweets per line" do
      expect(ArkTweetNlp::Parser.find_tags("faceboooooooook is awesome\nfaceboooooooook is awesome")).to eq([{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A} ])

    end
  end

  describe '#get_words_tagged_as' do
    it "returns only the words that where tagged with the specified tags" do
      tagged_result =[{'faceboooooooook' => :^,'is' => :V,'awesome' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A)).to eq(:A => (Set.new(['awesome']) ))
    end
    it "supports multiple tags" do
      tagged_result = [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A,:V,:^)).to eq( {:^ => Set.new(["faceboooooooook"]), :V => Set.new(["is"]), :A => Set.new(["awesome"]) })
    end
    it "supports muliple hashes" do
      tagged_result = [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A, 'blossom' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A,:V,:^)).to eq( {:^ => Set.new(["faceboooooooook"]), :V => Set.new(["is"]), :A => Set.new(["awesome","blossom"]) })
    end
  end
end
