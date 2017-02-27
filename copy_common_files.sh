#!/bin/sh
cp Gemfile* alpine/
cp Gemfile* elastic_mysql_alpine/
cp Gemfile* elastic_mysql_ubuntu/
cp Gemfile* elastic_mysql_ubuntu_ruby_2_4/
cp Gemfile* ruby_2_4/
cp docker-entrypoint.sh alpine/
cp docker-entrypoint.sh ruby_2_4/
git commit -a -m 'Update gems and entrypoints'
