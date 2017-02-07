RSpec.describe "new app", type: :cli do
  describe "umbrella project" do
    it "boots and displays a welcome page" do
      with_project do
        run_app do |app|
          expect(app.get("/")).to eq "<html><body><h1>Welcome to dry-web-roda!</h1></body></html>"
        end
      end
    end
  end

  describe "flat project" do
    it "boots and displays a welcome page" do
      with_project arch: "flat" do
        run_app do |app|
          expect(app.get("/")).to eq "<html><body><h1>Welcome to dry-web-roda!</h1></body></html>"
        end
      end
    end
  end
end
