namespace :couchbase do
  desc "Initializes the design documents"
  task :setup => :environment do
    views = [
      'all_articles_by_date',
      'all_comments_for_article_by_date'
    ]

    c = Couchbase.new(bucket: "alerti-test", :node_list => ['192.168.50.101'])

    path = ::File.expand_path('../../../db/couchbase/',  __FILE__)
    design_document = 'alerti_test'

    doc = {'_id' => "_design/#{design_document}", 'views' => {}}

    views.each do |name, _|
      doc['views'][name] = {}
      doc['spatial'] = {}
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

