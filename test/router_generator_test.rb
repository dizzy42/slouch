require "test_helper"
require "generators/slouch/router_generator"

class RouterGeneratorTest < ::Rails::Generators::TestCase
  tests ::Slouch::Generators::RouterGenerator

  MODEL_NAME = "ProductLine"

  arguments [MODEL_NAME]
  destination TMP_DIR

  setup    :prepare_destination
  setup    :create_application_js
  teardown :destroy_tmp_dir

  test "should create a router in the app namespace object" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /#{application_name} = \(\s*function/
  end

  test "should create a router in the Routers namespace" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /public_\.Routers\s+=/
  end

  test "should add router instantiation in backbone-app.js" do
    run_generator
    assert_file "app/assets/javascripts/backbone_app.js",
                /public_.initialize\s=\sfunction\(\)\s{/
    assert_file "app/assets/javascripts/backbone_app.js",
                /Backbone\.history\.start\({\spushState:\strue\s}\);/
  end

  test "should call the router init in application.js/dom ready" do
    run_generator
    assert_file "app/assets/javascripts/application.js",
                /\$\(function\(\)\s*{/
    assert_file "app/assets/javascripts/application.js",
                /#{application_name}\.initialize\(\);/
  end

  test "should create a skeleton router with routes and initialize properties" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /routes:\s{/
    assert_file "app/assets/javascripts/routers/router.js",
                /initialize:\sfunction\(\)\s{/
  end

  test "should create the properly namespaced routes for index" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /"#{MODEL_NAME.underscore.pluralize}":\s+"#{MODEL_NAME.pluralize}\.index"/
  end

  test "should create the properly namespaced routes for show" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /"#{MODEL_NAME.underscore.pluralize}\/:id":\s+"#{MODEL_NAME.pluralize}\.show"/
  end

  test "should create the properly namespaced routes for edit" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /"#{MODEL_NAME.underscore.pluralize}\/:id\/edit":\s+"#{MODEL_NAME.pluralize}\.edit"/
  end

  test "should create the properly namespaced routes for new" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /"#{MODEL_NAME.underscore.pluralize}\/new":\s+"#{MODEL_NAME.pluralize}\.new"/
  end

  test "should create namespace for methods" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /#{MODEL_NAME.pluralize}\s=\s{/
  end

  test "should create index method" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /index:\sfunction\(\)\s{/
  end

  test "should create show method" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /show:\sfunction\(id\)\s{/
  end

  test "should create edit method" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /edit:\sfunction\(id\)\s{/
  end

  test "should create new method" do
    run_generator
    assert_file "app/assets/javascripts/routers/router.js",
                /new:\sfunction\(\)\s{/
  end
end
