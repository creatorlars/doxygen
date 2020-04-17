#!/usr/bin/env bash
set -e
cd $PWD

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
	echo "Setup and run Jekyll"
	echo ""
	echo "Usage: ${0} [option]"
	echo ""
	echo "Options are not mandatory, only one at a time."
	echo "-a, --assets      Build minimized css style and js script from sources."
	echo "-i, --install     Install Bundler and node modules using Yarn."
	echo "-d, --doxygen     Build Doxygen documentation"
	echo ""
	exit 0
fi
if [ ! -d "node_modules" ] || [ "$1" == "-i" ] || [ "$1" == "--install" ]; then
	gem update
	gem install bundler
	bundle install
	yarn --no-bin-links
fi
if [ ! -f "assets/css/style.min.css" ] || [ "$1" == "-a" ] || [ "$1" == "--assets" ]; then
	mkdir -p assets/js
	yarn dist
fi
if [ ! -d "api" ] || [ "$1" == "-d" ] || [ "$1" == "--doxygen" ]; then
	python3 scripts/doxygen/doxy2json.py
fi
bundle exec jekyll serve --watch --host=0.0.0.0
