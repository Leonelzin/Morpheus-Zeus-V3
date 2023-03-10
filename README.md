# Morpheus
This project is a test automation framework for [**ZEUS OS** project](https://git.intelbras.com.br/zeus/openwrt).

It works along with [**Testberry** platform](https://git.intelbras.com.br/zeus/testberry).

---

[[_TOC_]]

---

# Table of acronyms
| Acronym | Meaning  |
| ---     | ---      |
| **DUT** | **D**evice **U**nder **T**est |
| **OS**  | **O**perating **S**ystem      |
| **POM** | **P**age **O**bject **M**odel |
| **RF**  | **R**obot **F**ramework       |

# Setup (GNU/Linux)
## 1. Install git
```
sudo apt install git
```

## 2. Install pyenv
Follow up to date instructions at: https://github.com/pyenv/pyenv#installation

## 3. Install Python version 3.8.5 using _pyenv_
First, we must install Python version 3.8.5:
```
pyenv install 3.8.5
```

The installation process will take a while (depends mostly on internet speed).

After the Python installation is completed, we can now enable it globally:
```
pyenv global 3.8.5
```

To check if its working properly, run the following command:
```
python --version
```

The output should be:
```
Python 3.8.5
```

## 4. Install poetry
Follow up to date instructions at: https://python-poetry.org/docs/#installation

After successful installation of **Poetry**, the following command must be executed once:
```
poetry config virtualenvs.in-project true
```

This configuration flag is used to set the Python virtual environment path into the project folder.

## 5. Get Morpheus project source code
Clone Morpheus project from Intelbras remote **git** repository:
```
git clone https://git.intelbras.com.br/zeus/morpheus.git
```

## 6. Install Morpheus project dependencies
Navigate to **morpheus/** (cloned from remote **git** repository):
```
cd <path>/<to>/morpheus/
```

Install project dependencies using **poetry**:

**ATTENTION:** this command should be executed inside **morpheus/** (where *`pyproject.toml`* file is located). 
```
poetry install
```

## 7. Activate Python virtual environment
**ATTENTION:** this command should be executed inside **morpheus/** (where *`pyproject.toml`* file is located).
```
poetry shell
```

Some messages should be shown while virtual environment is being activated.

Python virtual envrionment activation output reference:
```
pedro@pedro-i320:~/intelbras/zeus/repositories/morpheus$ poetry shell

Spawning shell within /home/pedro/intelbras/zeus/repositories/morpheus/.venv
. /home/pedro/intelbras/zeus/repositories/morpheus/.venv/bin/activate

pedro@pedro-i320:~/intelbras/zeus/repositories/morpheus$ . /home/pedro/intelbras/zeus/repositories/morpheus/.venv/bin/activate

(.venv) pedro@pedro-i320:~/intelbras/zeus/repositories/morpheus$
```

## 8. Create test environment files
It is **extremely important** to adjust variables in *`morpheus/environment.py`* according to the current testing environment. Otherwise, test execution will fail at some point. The same goes for *`morpheus/tests_to_run.py`*.

So, the first step is to create a local copy of *`morpheus/environment.py.template`* and rename the copy to *`environment.py`*:
```
cp environment.py.template environment.py
```

Then create a local copy of *`morpheus/tests_to_run.py.template`* and rename the copy to *`tests_to_run.py`*:
```
cp tests_to_run.py.template tests_to_run.py
```

## 9. Download webdriver and set *`WEBDRIVER_PATH`* and *`BROWSER`* variables
**Google Chrome**: https://chromedriver.chromium.org/downloads

**Mozilla Firefox**: https://github.com/mozilla/geckodriver/releases

Webdrivers can be placed inside *`morpheus/webdrivers/`* for organization purposes (it is not mandatory).

The user **must** provide webdriver path in *`morpheus/environment.py`* through variable **`WEBDRIVER_PATH`**.

The user **must** set **`BROWSER`** variable in *`morpheus/environment.py`*.

| Browser to run tests | Set **`BROWSER`** variable to |
| ---                  | ---                           |
| **Google Chrome**    | "Chrome"                      |
| **Mozilla Firefox**  | "Firefox"                     |

**ATTENTION:** one should *NEVER* commit anything inside *`morpheus/webdrivers/`* (except the `README.md` that's already there, of course), otherwise the remote git repository will soon be cluttered with a bunch of *webdriver* binaries.

## 10. Set environment variables
List of environment variables that **must** be set before starting test execution:

| Environment Variable | Explanation                          | Example                       |
| ---                  | ---                                  | ---                           |
| ITB_DEV_FW_PASSWORD  | set to DUT development firmware password | DevPassword123                |

**Example: command to set an environment variable**
```
export ITB_DEV_FW_PASSWORD=DevPassword123
```

This command must be executed every time a new shell session (terminal) is created (before starting test execution).

It is possible to add this command to the end of **`/home/user/.bashrc`** file. This will automatically set the environment variable every time a new shell session is created, so that the user does not need to execute the command **export** manually.

**Example of a `/home/user/.bashrc` file:**
```
FILE: /home/pedro/.bashrc

# many other commands and instructions here
# ...

# ZEUS OS: Intelbras development firmware password
export ITB_DEV_FW_PASSWORD=DevPassword123

```


# Run tests
**BEFORE STARTING TEST EXECUTION MAKE SURE THAT:**
1. Python virtual environment is active ([setup section 7](#7-activate-python-virtual-environment))
2. *`morpheus/environment.py`* is correctly configured ([setup section 8](#8-create-test-environment-files))
3. *`morpheus/tests_to_run.py`* is correctly configured ([setup section 8](#8-create-test-environment-files))
4. DUT **must** have its profile properly created in *`morpheus/devices/`*
5. Environment variables are set ([setup section 10](#10-set-environment-variables))

Navigate to **morpheus/** (cloned from remote **git** repository):
```
cd <path>/<to>/morpheus/
```

Start test execution:
```
python run_tests.py
```

The above command will evaluate DUT profile in runtime based on DUT model name.

It is also possible to manually set DUT profile through a command line argument (**`--device`**):
```
python run_tests.py --device devices/AP1350AC-S.py
```

If the command is executed correctly, some log messages will appear in the console.
These log messages are also written to a log file: **`morpheus/morpheus.log`**.

A copy of **`morpheus/morpheus.log`** file is created and placed inside test execution report directory.

[Read more about test execution reports.](#robot-framework-test-reports)

**Example of Morpheus message logs:**
```
(.venv) pedro@pedro-i320:~/intelbras/zeus/repositories/morpheus$ python run_tests.py

[2022-01-11 08:12:14,650] [ INFO     ] ---   INIT   ---
[2022-01-11 08:12:14,650] [ INFO     ] Initializing Morpheus
[2022-01-11 08:12:14,650] [ INFO     ] Test execution UNIX timestamp: 1641899534.6502907
[2022-01-11 08:12:14,650] [ INFO     ] Checking environment variables
[2022-01-11 08:12:14,650] [ INFO     ] Environment variable <ITB_DEV_FW_PASSWORD> is set
[2022-01-11 08:12:14,650] [ INFO     ] Environment variables OK
[2022-01-11 08:12:14,651] [ INFO     ] Evaluating DUT management information (from <morpheus/environment.py>)
[2022-01-11 08:12:14,651] [ INFO     ] DUT management WEB protocol: http
[2022-01-11 08:12:14,651] [ INFO     ] DUT management IPv4 address: 172.16.0.16
[2022-01-11 08:12:14,651] [ INFO     ] DUT management HTTP port: 80
[2022-01-11 08:12:14,651] [ INFO     ] DUT management URL: http://172.16.0.16:80
[2022-01-11 08:12:14,651] [ INFO     ] Retrieving DUT information through REST API call
[2022-01-11 08:12:14,652] [ INFO     ] DUT API endpoint: /cgi-bin/api/v3/system/device/info
[2022-01-11 08:12:14,752] [ INFO     ] DUT API response: b'{"data":{"opmode":"ap","api_version":"3","compliance_user_data":true,"network_mode":"bridge","uptime":69359,"model":"AP 1350 AC-S","hostname":"ap1350ac-s","language":"pt_BR","alias":"ap1350ac-s","version":"2.9.11"}}'
[2022-01-11 08:12:14,752] [ INFO     ] DUT information: {'model_name': 'AP 1350 AC-S', 'firmware_version': '2.9.11'}
[2022-01-11 08:12:14,753] [ INFO     ] Evaluating tests that will be executed
[2022-01-11 08:12:14,753] [ INFO     ] Parsing tests from <morpheus/tests_to_run.py>
[2022-01-11 08:12:14,754] [ INFO     ] Tests parsed: ['--include', 'wip', '--exclude', 'no-run', '--exclude', 'system', '--exclude', 'ethernet', '--exclude', 'lan', '--exclude', 'ntp', '--exclude', 'auto-configuration']
[2022-01-11 08:12:14,754] [ INFO     ] DUT profile will be evaluated in runtime
[2022-01-11 08:12:14,755] [ INFO     ] DUT profile evaluated: devices/AP1350AC-S.py
[2022-01-11 08:12:14,755] [ INFO     ] Test execution report directory will be evaluated in runtime
[2022-01-11 08:12:14,756] [ INFO     ] Creating test execution report directory name
[2022-01-11 08:12:14,756] [ INFO     ] DUT model name (original): AP 1350 AC-S
[2022-01-11 08:12:14,757] [ INFO     ] DUT model name (after removing spaces, '/' and '\'): AP1350AC-S
[2022-01-11 08:12:14,757] [ INFO     ] Test execution report directory name created: AP1350AC-S_2.9.11_1641899534
[2022-01-11 08:12:14,758] [ INFO     ] Test execution report directory set: reports/AP1350AC-S_2.9.11_1641899534
[2022-01-11 08:12:14,759] [ INFO     ] Invoking Robot Framework test execution
[2022-01-11 08:12:14,759] [ INFO     ] Robot Framework command: ['-d', 'reports/AP1350AC-S_2.9.11_1641899534', '-L', 'TRACE:INFO', '-P', 'libraries/', '-P', 'resources/', '-V', 'environment.py', '-V', 'devices/AP1350AC-S.py', '--include', 'wip', '--exclude', 'no-run', '--exclude', 'system', '--exclude', 'ethernet', '--exclude', 'lan', '--exclude', 'ntp', '--exclude', 'auto-configuration', 'tests/']
[2022-01-11 08:12:28,782] [ INFO     ] Test execution finished, exiting now
```

# Robot Framework test reports
At the end of a test execution all Robot Framework reports are placed inside [morpheus/reports/](reports/) by default.

The test initialization script [morpheus/run_tests.py](run_tests.py) creates a specific test report folder for every test execution. A test report folder follows this pattern:

```
morpheus/reports/DUTModelName_DUTFirmwareVersion_UNIXTimestamp/
```

It is possible to change where *Robot Framework* reports will be placed using the parameter **`-o`** to the run_tests.py script.

```
python run_tests.py -d devices/AP1350AC.py -o desired/reports/path/here
```

If the provided directory does not exist *Robot* will automatically create it as soon as it starts to run.

**ATTENTION:** one should *NEVER* commit anything inside *`morpheus/reports/`* (except the `README.md` that's already there, of course), otherwise the remote git repository will soon be cluttered with a bunch of reports and screenshots auto-generated by *Robot Framework*.

# Create test cases (how to contribute)
Refer to the [contributing guide](CONTRIBUTING.md).
