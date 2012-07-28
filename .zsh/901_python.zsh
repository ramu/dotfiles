#!/bin/zsh

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
   export WORKON_HOME=$HOME/.virtualenvs
   export VIRTUALENVWRAPPER_PYTHON=/Users/ramusara/.pythonbrew/pythons/Python-3.2/bin/python
   source /usr/local/bin/virtualenvwrapper.sh
fi
