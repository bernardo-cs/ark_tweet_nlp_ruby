require 'tempfile'
require 'set'

module ArkTweetNlp
  module Parser
    TAGSET = {
      :N => 'common noun',
      :O => 'pronoun, non possessive',
      :^ => 'proper noun',
      :S => 'nominal + possessive',
      :Z => 'proper noun + possessive',
      :V => 'verb including copula, auxiliaries',
      :L => 'nominal + verbal (e.g. i’m), verbal + nominal (let’s)',
      :M => 'proper noun + verbal',
      :A => 'adjective',
      :R => 'adverb',
      :! => 'interjection',
      :D => 'determiner',
      :P => 'pre- or postposition, or subordinating conjunction',
      :& => 'coordinating conjunction',
      :T => 'verb particle',
      :X => 'existential there, predeterminers',
      :Y => 'X + verbal',
      :'#' => 'hashtag (indicates topic/category for tweet)',
      :'@' => 'at-mention (indicates a user as a recipient of a tweet)',
      :~ => 'discourse marker, indications of continuation across multiple tweets',
      :U => 'URL or email address',
      :E => 'emoticon',
      :'$' => 'numeral',
      :',' => 'punctuation',
      :G => 'other abbreviations, foreign words, possessive endings, symbols, garbage'
    }
    #spec = Gem::Specification.find_by_name("ark_tweet_nlp")
    #gem_root = spec.gem_dir
    #gem_bin = gem_root + "/bin"
    TAGGER_PATH = File.join(Gem::Specification.find_by_name("ark_tweet_nlp").gem_dir, 'bin', 'runTagger.sh')

    def Parser.ola
      "ola"
    end

    def Parser.find_tags text
      result = Parser.run_tagger(text)
      result.split("\n").map{ |line| Parser.convert_line( line ) }
    end

    def Parser.get_words_tagged_as tagged_result, *tags
      Parser.merge_array( tagged_result.map{ |e| Parser.safe_invert( e ).select{ |key| tags.include? key } })
    end

    private
    def Parser.merge hash1, hash2
      hash2.each{ |key, value| hash1[key] ||= Set.new; hash1[key] << value }
    end

    # merges all hashs inside array
    def Parser.merge_array arr
      arr.each.inject({}){ |res,hash| Parser.merge(res,hash) }
    end

    #def Parser.run_tagger text
      ##FIXME: regex destroyes urls...
      #`echo "#{text.gsub(/[^\w\s\d#]/, '')}" | #{TAGGER_PATH}`
    #end
    def Parser.run_tagger text
      file = Tempfile.new('tweets')
      file.write(text)
      file.rewind
      `#{TAGGER_PATH} #{file.path}`
    end

    def Parser.convert_line line
      text = line.split("\t")[0].split
      tags = line.split("\t")[1].split
      text.each.with_index.inject({}){ |result,(value,index)| result[value] = tags[index].to_sym; result }
    end

    def Parser.safe_invert hash
       hash.each.inject({}){|sum,val| sum[val.last] ||= Set.new; sum[val.last] << val.first; sum}
    end

  end
end
