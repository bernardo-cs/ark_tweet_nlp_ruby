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
      expect(ArkTweetNlp::Parser.find_tags("I think I haven't had a segmentation fault in years http://t.co/COjaaFj6Ib")).to eq(       [{"I"=>:O,
         "think"=>:V,
         "havent"=>:V,
         "had"=>:V,
         "a"=>:D,
         "segmentation"=>:N,
         "fault"=>:N,
         "in"=>:P,
         "years"=>:N,
         "httptcoCOjaaFj6Ib"=>:"$"}])
    end
    it "removes ponctuation from the tweets" do
      expect(ArkTweetNlp::Parser.find_tags("Delayed... And waiting on a tire from Louisville. \"You can't be serious #Disappointed #pissed #letdown http://t.co/BFqsPZmr8m")).to eq([{"Delayed"=>:A,
         "And"=>:&,
         "waiting"=>:V,
         "on"=>:P,
         "a"=>:D,
         "tire"=>:N,
         "from"=>:P,
         "Louisville"=>:^,
         "You"=>:O,
         "cant"=>:V,
         "be"=>:V,
         "serious"=>:A,
         "#Disappointed"=>:"#",
         "#pissed"=>:"#",
         "#letdown"=>:"#",
         "httptcoBFqsPZmr8m"=>:"#"}])
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
