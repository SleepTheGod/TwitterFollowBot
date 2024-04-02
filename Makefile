PYPREFIX_PATH=/usr
PYTHONPATH=$(PYPREFIX_PATH)/bin/python3  # Assuming you're now using Python 3
PIP=pip3  # Use pip3 for Python 3
PYTHON=bin/python
VIRTUALENV=python3 -m venv  # Use Python 3's built-in venv module
SOURCE_ACTIVATE=. bin/activate;

bin/activate: requirements.txt
	@echo "[ using        ] $(PYTHONPATH)"
	@echo "[ installing   ] virtualenv"
	@echo "[ creating     ] virtual environment"
	@$(VIRTUALENV) .  # No need for --no-site-packages
	@echo "[ upgrading    ] pip"
	@$(SOURCE_ACTIVATE) $(PIP) install --upgrade pip
	@echo "[ installing   ] project requirements"
	@$(SOURCE_ACTIVATE) $(PIP) install -r requirements.txt
	@touch bin/activate

deploy: bin/activate
	@echo "[ deployed     ] the system was completely deployed"

show-version:
	@$(SOURCE_ACTIVATE) $(PYTHON) --version

shell:
	@$(SOURCE_ACTIVATE) ipython

pypi-register:  # This is deprecated in favor of Twine
	@echo "[ deprecated   ] use Twine to upload packages to PyPI"

pypi-upload:  # Updated to use Twine
	@echo "[ uploading    ] package to PyPI servers"
	@$(SOURCE_ACTIVATE) twine upload dist/* 
	@echo "[ uploaded     ] the new version was successfully uploaded"

clean:
	@echo "[ cleaning     ] remove deployment generated files that don't exist in the git repository"
	rm -rf bin/ include/ lib/ lib64/ share/ pip-selfcheck.json .Python dist/ *egg-info/ build/
