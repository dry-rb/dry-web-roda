RSpec.describe "new app", type: :cli do
  it "boots and displays a welcome page" do
    with_project do
      run_app do |app|
        expect(app.get("/")).to eq "<html><body><h1>Welcome to dry-web-roda!</h1></body></html>"
      end
    end
  end
end
