# frozen_string_literal: true

namespace :multiversion do
  desc 'Checkout versioned branches to versioned directories using version map from Docfile'
  task :init do
    puts 'Creating versioned content using version map from Docfile'
    versions.each do |version|
      add_version(version['directory'], version['branch'])
    end
    list_trees
  end

  desc 'Delete versioned directories and checkout them from scratch'
  task :reinit do
    versions.each do |version|
      dir = version['directory']
      remove_version(dir)
      add_version(dir, version['branch'])
    end
    list_trees
  end

  desc 'Delete versioned directories and checkout them from scratch'
  task :rm do
    versions.each do |version|
      remove_version(version['directory'])
    end
  end
end

def versions
  Docfile.read['version_map']
end

def list_trees
  puts "\nThe repository contains the following worktrees now:".magenta
  system "git worktree list --porcelain"
end

def remove_version(directory)
  if File.exist?(directory)
    puts "\nRemoving #{directory}".yellow
    sh('git', 'worktree', 'remove', directory)
  end
end

def add_version(directory, branch)
  if File.exist?(directory)
    puts "The #{directory} already exists.".yellow
  else
    puts "Checking out files from the #{branch} branch to the #{directory} directory ...".magenta
    sh('git', 'worktree', 'add', directory, branch) do |ok,res|
      if !ok
        abort "Cannot checkout files for #{branch}".red
      end
    end
  end
end
