require 'rails_helper'

describe "ShortUrls", type: :request do

  describe "GET /url" do
    let!(:short_urls) { create(:short_url) }

    it "returns a not found response" do
      get "/dummy"
      expect(response.status).to eq(404)
      response_body = JSON.parse(response.body)
      expect(response_body['errors']).to eq('Url Not Found')
    end

    it "redirects for valid url" do
      expect(get "/#{short_urls.shorted_url}").to redirect_to(short_urls.original_url)
    end
  end

  describe "Post /generate" do
    it "returns success response for valid url" do
      post '/short_urls/generate', headers: { 'HTTP_ACCEPT' => "application/json" }, params: {url: "http://www.test.com"}
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['url']).not_to be(nil)
    end
    #
    it "returns a error response for invalid url" do
      post '/short_urls/generate',headers: { 'HTTP_ACCEPT' => "application/json" }, params: {url: "dummy"}
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body)
      expect(response_body['errors']).not_to be(nil)
    end
  end
end