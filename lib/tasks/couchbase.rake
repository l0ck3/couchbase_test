namespace :couchbase do
  desc "Initializes the design documents"
  task :setup => :environment do

    documents = {
      article: {
        views: [
          'all_articles_by_date',
          'count_total_articles'
        ]
      },
      comment: {
        views: [
          'moderated_comments_for_article_by_date',
          'all_comments_for_article_by_date',
          'comments_ids_for_article',
        ]
      }
    }

      c = Couchbase.new(
        bucket: "alerti-test",
        :hostname => 'localhost'
      )

    base_path = ::File.expand_path('../../../db/couchbase/',  __FILE__)
    #design_document = 'alerti_test'

    documents.each do |name, value|
      path = File.join(base_path, name.to_s)
      doc = {'_id' => "_design/#{name}", 'views' => {}}
      value[:views].each do |name|
        doc['views'][name] = {}
        ['map', 'reduce'].each do |type|
          ff = File.join(path, name.to_s, "_#{type}.js")
          if File.file?(ff)
            contents = File.read(ff).gsub(/^\s*\/\/.*$\n\r?/, '').strip
            next if contents.empty?
            doc['views'][name][type] = contents
          end
        end
      end
      c.save_design_doc(doc)
    end

  end
end



