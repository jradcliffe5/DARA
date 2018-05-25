#!/bin/bash
#sudo apt-get install ruby ruby-dev build-essential
#echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
#echo 'export GEM_HOME=$HOME/gems' >> ~/.bashrc
#echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bashrc
#source ~/.bashrc
#gem install jekyll bundler

cp init_gemfile.txt Gemfile
bundle install
bundle exec jekyll _3.3.0_ new local_site
rm local_site/index.md local_site/_config.yml
cd local_site; git init
git remote add origin https://github.com/jradcliffe5/Development-in-Africa-Unit-4.git
git pull origin master
sed '/# gem "github-pages", group: :jekyll_plugins/s/.*/gem "github-pages", group: :jekyll_plugins/' Gemfile >> Gemfile2
mv Gemfile2 Gemfile
bundle exec jekyll serve
