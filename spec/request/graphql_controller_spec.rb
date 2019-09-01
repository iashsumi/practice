describe GraphqlController, type: :request do
  describe '#execute' do
    let(:query_string) { '{ users {name} }' }
    before do
      create(:user, name: 'test_name')
    end

    it 'success' do
      post graphql_path, params: { query: query_string }
      expect(response.status).to eq 200
    end

    it 'return name' do
      post graphql_path, params: { query: query_string }
      expect(response.body).to include 'test_name'
    end
  end
end
