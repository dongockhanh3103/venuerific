# frozen_string_literal: true

module PostOperation
  class SearchPost < BaseOperation

    # @param [Hash] params The search parameters
    # ex: { keyword: 'post', page: 1 }
    def initialize(params)
      super()

      @keyword = params[:keyword]
      @page = params[:page]
      @queries = []
      @values = []
    end

    # Get posts
    #
    # @return [Array] The list of post
    def execute
      search_by_criteria
    end

    private

    def search_by_criteria
      search_by_title

      scope.where(@queries.join(' OR '), *@values).paginate(page: @page)
    end

    def search_by_title
      return if @keyword.blank?

      @values << "%#{@keyword.downcase}%"
      @queries << 'LOWER(posts.title) LIKE ? '
    end

    def scope
      Post.all
    end

  end
end
