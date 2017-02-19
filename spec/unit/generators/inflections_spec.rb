require "dry/web/roda/generators/inflections"

RSpec.describe Dry::Web::Roda::Generators::Inflections do
  subject(:inflections) { described_class }

  describe ".underscored_name" do
    it "leaves an already underscored name" do
      expect(inflections.underscored_name("my_app")).to eq "my_app"
    end

    it "leaves a name without any sort of delimiters" do
      expect(inflections.underscored_name("myapp")).to eq "myapp"
    end

    it "converts a dashed name" do
      expect(inflections.underscored_name("my-app")).to eq "my_app"
    end
  end

  describe ".camel_cased_name" do
    it "leaves an already camel cased name" do
      expect(inflections.camel_cased_name("MyApp")).to eq "MyApp"
    end

    it "converts a dashed name" do
      expect(inflections.camel_cased_name("my-app")).to eq "MyApp"
    end

    it "converts an underscored name" do
      expect(inflections.camel_cased_name("my_app")).to eq "MyApp"
    end
  end
end
