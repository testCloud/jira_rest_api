require 'spec_helper'

describe JiraRestApi::Resource::Comment do

  with_each_client do |site_url, client|
    let(:client) { client }
    let(:site_url) { site_url }

    let(:key) { "10000" }

    let(:target) { JiraRestApi::Resource::Comment.new(client, :attrs => {'id' => '99999'}, :issue_id => '54321') }

    let(:expected_collection_length) { 2 }

    let(:belongs_to) {
      JiraRestApi::Resource::Issue.new(client, :attrs => {
        'id' => '10002',
        'fields' => {
          'comment' => {'comments' => []}
        }
      })
    }

    let(:expected_attributes) do
      {
        'self' => "http://localhost:2990/jira/rest/api/2/issue/10002/comment/10000",
        'id'   => key,
        'body' => "This is a comment. Creative."
      }
    end

    let(:attributes_for_post) {
      { "body" => "new comment" }
    }
    let(:expected_attributes_from_post) {
      { "id" => "10001", "body" => "new comment"}
    }

    let(:attributes_for_put) {
      {"body" => "new body"}
    }
    let(:expected_attributes_from_put) {
      { "id" => "10000", "body" => "new body" }
    }

    it_should_behave_like "a resource"
    it_should_behave_like "a resource with a collection GET endpoint"
    it_should_behave_like "a resource with a singular GET endpoint"
    it_should_behave_like "a resource with a DELETE endpoint"
    it_should_behave_like "a resource with a POST endpoint"
    it_should_behave_like "a resource with a PUT endpoint"

  end

end
