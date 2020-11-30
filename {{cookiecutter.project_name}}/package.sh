#!/bin/bash
# prepare a source code package

pip install --upgrade --target package/ -r requirements.txt
cd package
zip -r9 ${OLDPWD}/package.zip .
cd ${OLDPWD}

zip -g -r package.zip {{cookiecutter.script_dir_name}}

rm -rf package