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
    it "suports urls" do
      expect(ArkTweetNlp::Parser.find_tags("I think I haven't had a segmentation fault in years http://t.co/COjaaFj6Ib")).to eq( [{"I"=>:O, "think"=>:V, "haven't"=>:V, "had"=>:V, "a"=>:D, "segmentation"=>:N, "fault"=>:N, "in"=>:P, "years"=>:N, "http://t.co/COjaaFj6Ib"=>:U}] )
    end
    it "supoorts ponctuation from the tweets, but removes \t" do
      expect(ArkTweetNlp::Parser.find_tags("Delayed... And waiting on \t a tire from Louisville. \"You can't be serious #Disappointed #pissed #letdown http://t.co/BFqsPZmr8m")).to eq([{"Delayed"=>:V, "..."=>:",", "And"=>:&, "waiting"=>:V, "on"=>:P, "a"=>:D, "tire"=>:N, "from"=>:P, "Louisville"=>:^, "."=>:",", "\""=>:",", "You"=>:O, "can't"=>:V, "be"=>:V, "serious"=>:A, "#Disappointed"=>:"#", "#pissed"=>:"#", "#letdown"=>:"#", "http://t.co/BFqsPZmr8m"=>:U}])
    end
    it "tags multiple tweets per line" do
      expect(ArkTweetNlp::Parser.find_tags("faceboooooooook is awesome\nfaceboooooooook is awesome")).to eq([{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A} ])

    end
    it 'supports empty strings' do
      expect(ArkTweetNlp::Parser.find_tags("\t\t\t\nfaceboooooooook is awesome\nfaceboooooooook is awesome")).to eq([{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A} ])
    end
  end

  describe '#get_words_tagged_as' do
    it "returns only the words that where tagged with the specified tags" do
      tagged_result =[{'faceboooooooook' => :^,'is' => :V,'awesome' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A)).to eq({:A=>["awesome"]} )
    end
    it "supports multiple tags" do
      tagged_result = [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A,:V,:^)).to eq({:^ => ["faceboooooooook"], :V => ["is"], :A => ["awesome"]})
    end
    it "supports muliple hashes" do
      tagged_result = [{'faceboooooooook' => :^,'is' => :V,'awesome' => :A},{'faceboooooooook' => :^,'is' => :V,'awesome' => :A, 'blossom' => :A}]
      expect(ArkTweetNlp::Parser.get_words_tagged_as(tagged_result, :A,:V,:^)).to eq({:^ => ["faceboooooooook", "faceboooooooook"], :V => ["is", "is"], :A => ["awesome", "awesome", "blossom"]})
    end
  end
end
