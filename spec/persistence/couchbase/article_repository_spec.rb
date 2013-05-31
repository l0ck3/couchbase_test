require 'spec_helper'
require 'couchbase'

module Couchbase

  bucket ||= Couchbase.connect(bucket: "test-alerti-test", hostname: "192.168.42.101")
  ArticleRepository.instance_variable_set(:@bucket, bucket)

  describe ArticleRepository do

    FakeUser = Struct.new(:id, :username)

    subject { ArticleRepository }

    #before(:all) { bucket.flush }


    let(:article) do
      article = Article.new(title: 'An article', content: 'A big content blah blah blah ....')
      article.user = FakeUser.new(42, 'power_user')
      article
    end

    describe '.save' do
      context 'given a new valid article' do
        it 'sets the id of the article to an UUID' do
          article.id.should be_nil
          saved_article = subject.save(article)
          saved_article.id.length.should == 36
        end

        it 'saves it to the repository and returns the saved version' do
          saved_article = subject.save(article)
          retrieved_article = bucket.get(saved_article.id)

          retrieved_article[:id] == saved_article.id
        end
      end

      describe 'given an invalid article' do

        before(:each) { article.title = nil }

        it 'returns false and does not persist it' do
          saved_article = subject.save(article)
          saved_article.should be_false
        end
      end

    end

    # describe '.all' do
    #   before(:all) do
    #     5.times do |index|
    #       ProductRepository.save(FakeProduct.new(sku: "1234567890#{index}", label: 'A good product'))
    #     end
    #   end

    #   it 'returns all the products' do
    #     subject.all.length.must_equal 5
    #   end
    # end

  end
end

