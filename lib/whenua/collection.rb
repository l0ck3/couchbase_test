module Whenua
  class Collection
    attr_writer :array

    delegate :each, to: :array

    def initialize(page=1, limit=10, count=0)
      @count = count
      @page  = page.to_i
      @limit = limit
    end

    def array
      @array
    end

    def current_page
      @page
    end

    def skip_value
      (current_page - 1) * limit_value
    end

    def total_pages
      total_rows / limit_value + (total_rows % limit_value != 0 ? 1 : 0)
    end

    def limit_value
      @limit
    end

    def total_rows
      @count
    end
  end

end
