from setuptools import setup, find_packages
from version import find_version

setup(
        name = 'pyks',
        author = 'Jiaxiang Li',
        author_email = 'alex.lijiaxiang@foxmail.com',
        description = 'Calculate KS for models',
        license = 'MIT',
        version = find_version('pyks', '__init__.py'),
        packages = find_packages()
     )
