namespace :multirepo do
  desc 'Add docs from external repositories (mftf, page-builder)'
  task :init do
    sh './scripts/docs-from-code.sh mftf git@github.com:magento-devdocs/magento2-functional-testing-framework.git docs-in-code'
    sh './scripts/docs-from-code.sh page-builder git@github.com:magento-devdocs/magento2-page-builder.git ds_docs-in-code'
  end

  desc 'Add multirepo docs providing arguments "dir", "repo", and "branch". Example: rake multirepo:add dir=mftf repo=git@github.com:magento-devdocs/magento2-functional-testing-framework.git branch=docs-in-code'
  task :add do
    dir = ENV['dir']
    repo = ENV['repo']
    branch = ENV['branch']

    sh "./scripts/docs-from-code.sh #{dir} #{repo} #{branch}"
  end
end
