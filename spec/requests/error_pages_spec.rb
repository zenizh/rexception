require 'spec_helper'

describe 'ErrorPages' do
  shared_examples_for 'error page' do |path:, code:, content:|
    it "should return #{code}" do
      visit path

      expect(page.status_code).to eq(code)
      expect(page).to have_content(content)
    end
  end

  context 'access to 403 page' do
    it_behaves_like 'error page', {
        path: '/forbidden',
        code: 403,
        content: 'Forbidden'
      }
  end

  context 'access to 404 page' do
    it_behaves_like 'error page', {
        path: '/not_found',
        code: 404,
        content: 'Not Found'
      }
  end

  context 'access to 500 page' do
    it_behaves_like 'error page', {
        path: '/internal_server_error',
        code: 500,
        content: 'Internal Server Error'
      }
  end
end
