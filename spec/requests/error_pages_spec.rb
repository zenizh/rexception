require 'spec_helper'

describe 'Error pages' do
  shared_examples_for 'error page' do |path, code, content|
    it "should return #{code}" do
      visit path

      expect(page.status_code).to eq code
      expect(page).to have_content content
    end
  end

  context 'access to 403 page' do
    it_behaves_like 'error page', '/forbidden', 403, 'Forbidden'
  end

  context 'access to 404 page' do
    it_behaves_like 'error page', '/not_found', 404, 'Not Found'
  end

  context 'access to 500 page' do
    it_behaves_like 'error page', '/application_error', 500, 'Application Error'
  end
end
