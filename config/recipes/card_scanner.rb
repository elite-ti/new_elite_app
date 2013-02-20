namespace :card_scanner do
  desc "Compile card scanner"
  task :compile, roles: :app do
    run "ruby #{current_path}/lib/card_scanner/type_b/compile.rb"
  end
  after "deploy:finalize_update", "card_scanner:compile"
end