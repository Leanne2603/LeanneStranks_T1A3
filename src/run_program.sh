#!/bin/sh
echo "Welcome to the Quiz Bites Application"
echo "The install will be finished shortly"
git clone "https://github.com/Leanne2603/LeanneStranks_T1A3"
cd LeanneStranks_T1A3/src
echo "Please wait whilst the gems are installed"
bundle install
echo "The application will run shortly"
ruby main.rb