require_relative '../minitest-helper'
require_relative '../test-utilities'

require_relative '../../lib/sinatra/swagger-exposer/configuration/swagger-info'

class TestSwaggerInfo < Minitest::Test

  describe Sinatra::SwaggerExposer::Configuration::SwaggerInfo do

    include TestUtilities

    it 'must fail with a unknown values' do
      must_raise_swag_and_equal(
        -> { new_info({:unknown => :something}) },
        'Unknown property [unknown] for info, possible values are contact, description, license, termsOfService, title, version'
      )
      must_raise_swag_and_equal(
        -> { new_info({:contact => {:unknown => :something}}) },
        'Unknown property [unknown] for info, possible values are email, name, url'
      )
    end

    it 'must fail when a top level hash value has a wrong type' do
      bad_contact = {:contact => []}
      must_raise_swag_and_equal(
        -> { new_info(bad_contact) },
        "Property [contact] value [[]] should be a Hash for info: #{bad_contact}"
      )
      bad_contact_string = {:contact => 'plop'}
      must_raise_swag_and_equal(
        -> { new_info(bad_contact_string) },
        "Property [contact] value [plop] should be a Hash for info: #{bad_contact_string}"
      )
    end

    it 'must fail when a top level string value has a wrong type' do
      bad_title_array = {:title => []}
      must_raise_swag_and_equal(
        -> { new_info(bad_title_array) },
        "Property [title] value [[]] should be a String for info: #{bad_title_array}"
      )
      bad_title_hash = {:title => {}}
      must_raise_swag_and_equal(
        -> { new_info(bad_title_hash) },
        "Property [title] value [{}] should be a String for info: #{bad_title_hash}"
      )
    end

    it 'must fail when a second level string value has a wrong type' do
      bad_contact_name_array = {:contact => {:name => []}}
      must_raise_swag_and_equal(
        -> { new_info(bad_contact_name_array) },
        "Property [name] value [[]] should be a String for info: #{bad_contact_name_array}"
      )
      bad_contact_name_hash = {:contact => {:name => {}}}
      must_raise_swag_and_equal(
        -> { new_info(bad_contact_name_hash) },
        "Property [name] value [{}] should be a String for info: #{bad_contact_name_hash}"
      )
    end

    it 'must return the right values' do
      content = {:contact => {:name => 'me'}, :version => '1.0'}
      new_info(content).to_swagger.must_equal content
    end

    it 'must return the values with keys as symbols' do
      content_string = {'contact' => {'name' => 'me'}, 'version' => '1.0'}
      content_symbol = {:contact => {:name => 'me'}, :version => '1.0'}
      new_info(content_string).to_swagger.must_equal content_symbol
    end

    it 'must return nil when there is no property' do
      new_info({}).to_swagger.must_be_nil
    end

    it 'must answer to to_s' do
      JSON.parse(new_info({:version => '1.0'}).to_s).must_equal({'version' => '1.0'})
    end


  end

end
