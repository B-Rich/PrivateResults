desc "Run all newman tests"
task :newman do
  environment_file = 'spec/data/Private-Results-Local.postman_environment'
  collection_file = 'spec/data/Private-Results-API.json.postman_collection'

  sh "newman -c #{collection_file} -e #{environment_file}"
end

