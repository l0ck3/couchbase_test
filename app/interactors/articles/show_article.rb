module Interactors
  module Articles
    class ShowArticle

      def exec(id)
        article = Couchbase::ArticleRepository.get(id)
        Response.new(article: article)
      end

    end
  end
end
