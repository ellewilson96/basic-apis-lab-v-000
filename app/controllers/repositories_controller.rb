class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
    @resp = Faraday.get ' https://api.github.com/search/repositories' do |req|
        req.params['client_id'] = '11TR0GATVWADKTY34TC2ZOWPM1V3O1XMRG3OIJ3B55XHVK2K'
        req.params['client_secret'] = 'RKLE5QI2ZE3K2GOYJIRTT5XOTOA0FEALIPJQ3H4G0PBVUXGF'
        req.params['q'] = 'ruby'
        req.params['sort'] = params[:stars]
        req.params['order'] = 'asc'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @repositories = body["response"]["repositories"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
