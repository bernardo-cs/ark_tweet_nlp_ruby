require_relative "../lib/ark_tweet_nlp/parser.rb"
include ArkTweetNlp::Parser

describe ArkTweetNlp do
  it " says ola" do
   expect(ArkTweetNlp::Parser.ola).to eq("ola")
  end
end
