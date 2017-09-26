# encoding: utf-8

$: << 'RspecTests/Generated/azure_resource_inheritance'

require 'rspec'
require 'generated/resource_inheritance'

include AzureResourceInheritanceModule

describe 'ResourceInheritance' do
  before(:all) do
    @base_url = ENV['StubServerURI']

    dummyToken = 'dummy12321343423'
    @credentials = MsRest::TokenCredentials.new(dummyToken)

    @client = AzureResourceInheritanceTest.new(@credentials, @base_url)
  end

  it 'should generate expected resource models' do
    modules = Module.const_get('AzureResourceInheritanceModule::Models')

    # Should generate AzureResource class
    azure_resource = modules.const_get('AzureResource')
    expect(azure_resource.is_a?(Class)).to be_truthy

    # Should generate LikeAzureResource class
    like_azure_resource = modules.const_get('LikeAzureResource')
    expect(like_azure_resource.is_a?(Class)).to be_truthy

    # Should generate AzureResourceAdditionaProperties class
    azure_resource_additional_properties = modules.const_get('AzureResourceAdditionaProperties')
    expect(azure_resource_additional_properties.is_a?(Class)).to be_truthy

    # Should not generate Resource class
    expect { modules.const_get('Resource') }.to raise_error(NameError)
  end

  it 'should generate models with expected inheritance' do
    modules = Module.const_get('AzureResourceInheritanceModule::Models')

    # Should generate InheritMsRestAzureResource with super class as MsRestAzure::Resource
    inherit_ms_rest_azure_resource = modules.const_get('InheritMsRestAzureResource')
    expect(inherit_ms_rest_azure_resource.is_a?(Class)).to be_truthy
    expect(inherit_ms_rest_azure_resource.superclass.name).to eq('MsRestAzure::Resource')

    # Should generate InheritAzureResource with super class as AzureResource
    inherit_azure_resource = modules.const_get('InheritAzureResource')
    expect(inherit_azure_resource.is_a?(Class)).to be_truthy
    expect(inherit_azure_resource.superclass.name).to eq('AzureResourceInheritanceModule::Models::AzureResource')

    # Should generate InheritAzureResourceAdditionaProperties with super class as AzureResourceAdditionaProperties
    azure_resource_additional_properties = modules.const_get('InheritAzureResourceAdditionaProperties')
    expect(azure_resource_additional_properties.is_a?(Class)).to be_truthy
    expect(azure_resource_additional_properties.superclass.name).to eq('AzureResourceInheritanceModule::Models::AzureResourceAdditionaProperties')
  end
end