class SearchController < ApplicationController
    def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title', 'text']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            text: {}
          }
        }
      }
    )
    end

    def search
      if params[:term].nil?
        @posts = []
      else
        term = params[:term]
        @posts = Post.search term, fields: [:text], highlight:  true
      end
    end

    def typeahead
      render json: Post.search(params[:term], {
        fields: ["title"],
        limit: 10,
        load: false,
        misspellings: {below: 5},
      }).map do |post| { title: post.title, value: post.id } end
    end
end
