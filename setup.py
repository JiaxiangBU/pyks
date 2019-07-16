from setuptools import setup, find_packages
from version import find_version

setup(
        name = 'pyKS',
        author = 'Jiaxiang Li',
        description = 'Calculate KS for models',
        license = 'MIT',
        version = find_version('once', '__init__.py'),
        packages = find_packages()
     )
