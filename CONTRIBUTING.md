# Morpheus

This project is a test automation framework for [**ZEUS OS** project](https://git.intelbras.com.br/zeus/openwrt).

It works along with [**Testberry** platform](https://git.intelbras.com.br/zeus/testberry).

---

[[_TOC_]]

---

# Table of acronyms

| Acronym | Meaning  |
| ---     | ---      |
| **e2e** | **E**nd-**T**o-**E**nd  |
| **RF**  | **R**obot **F**ramework |

# IDE setup (recommended extensions)

## Visual Studio Code (VS Code)

There are some good [VS Code](https://code.visualstudio.com/) extensions that facilitates development, therefore **increasing productivity**.

### Python

VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=ms-python.python

```
Name: Python
Id: ms-python.python

Description: IntelliSense (Pylance), Linting, Debugging (multi-threaded, remote),
             Jupyter Notebooks, code formatting, refactoring, unit tests, and
             more.

Version: 2021.12.1559732655
Publisher: Microsoft
```

### GitLens

VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens

```
Name: GitLens — Git supercharged
Id: eamodio.gitlens

Description: Supercharge the Git capabilities built into Visual Studio Code
             — Visualize code authorship at a glance via Git blame annotations
             and code lens, seamlessly navigate and explore Git repositories,
             gain valuable insights via powerful comparison commands, and so
             much more

Version: 11.7.0
Publisher: GitKraken
```

### Robot Framework Language Server

VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp

```
Name: Robot Framework Language Server
Id: robocorp.robotframework-lsp

Description: VSCode extension support for Robot Framework

Version: 0.34.0
Publisher: Robocorp
```

This extension have some **important settings** that **must be** properly configured after its installed.

Access this extension settings in your IDE. You will need to access VS Code settings for that.

**Tip:** there is a shorcut to open VS Code settings (verified on a Debian based GNU/Linux distro):
```
Ctrl + ,
```

If the shortcut does not work for any reason, it is possible to go there manually by clicking on the **gear icon** (:gear:) that is located at the bottom left of VS Code IDE. There is an option called "**Settings**" (probably the second option) and that is what you are looking for.

Another way to access the extension settings is through the extensions panel itself. Open the extensions panel and access the **Robot Framework Language Server** extension, a tab containing extension information should open.

There is a **gear icon** (:gear:) in the tab that was just opened. Click that icon and access "**Extension Settings**".

Given that VS Code settings panel is opened, copy and paste the following text into the settings search bar to view all settings related to **Robot Framework Language Server** extension:
```
@ext:robocorp.robotframework-lsp
```

There should be two tabs right below the settings search box:
- User
- Workspace

Select "**Workspace**" tab and proceed with the setup described below.

- **`Robot > Completions > Keywords: Format`**: Title Case

- **`Robot > Completions > Section_headers: Form`**: plural

- **`Robot > Language-server: Python`**: /path/to/morpheus/.venv/bin/python

- **`Robot: Pythonpath`**: click on "**`Edit in settings.json`**". A file called "**settings.json**" will be opened. Add the following paths to **`robot.pythonpath`** list:

    ```
    {
        "robot.pythonpath": [
            "/path/to/morpheus",
            "/path/to/morpheus/libraries",
            "/path/to/morpheus/resources",
        ]

    # there will be other settings here...
    # note that all settings you defined
    # before are also in this file.
    }
    ```

    Here is a full example of a **`settings.json`** file for reference:
    ```
    {
        "robot.pythonpath": [
            "/home/pedro/intelbras/zeus/repositories/morpheus",
            "/home/pedro/intelbras/zeus/repositories/morpheus/libraries",
            "/home/pedro/intelbras/zeus/repositories/morpheus/resources",
        ],
        "robot.completions.keywords.format": "Title Case",
        "robot.language-server.python": "/home/pedro/intelbras/zeus/repositories/morpheus/.venv/bin/python",
        "files.exclude": {
            "**/.git": true,
            "**/__pycache__": true,
        }
    }
    ```

    "**`files.exclude`**" was added manually just to hide some files in VS Code file explorer.

**IMPORTANT:** reopen VS Code after setting up the extension. **All set!**

### Material Icon Theme

VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme

```
Name: Material Icon Theme
Id: pkief.material-icon-theme

Description: Material Design Icons for Visual Studio Code

Version: 4.11.0
Publisher: Philipp Kief
```

### Todo Tree

VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree

```
Name: Todo Tree
Id: gruntfuggly.todo-tree

Description: Show TODO, FIXME, etc. comment tags in a tree view

Version: 0.0.214
Publisher: Gruntfuggly
```

## PyCharm

It is possible to extend [Robot Framework](https://robotframework.org/) by creating [custom libraries](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-test-libraries) that are programmed in Python.

Since [PyCharm](https://www.jetbrains.com/pycharm/) is another common IDE among Python programmers, it would be great to have some setup information here.

Please contribute if you are involved in this project and using PyCharm IDE.

## Other IDEs

Please contribute if you are involved in this project and using another IDE that is not yet been mentioned in this document.

# Contribution steps (JIRA and git/GitLab instructions)

This project source code is maintained in a [GitLab remote repository hosted by Intelbras](https://git.intelbras.com.br/zeus/morpheus).

The first step to start contributing is to make sure that a JIRA card related to the contribution is created in [DevOps board (project "Plataforma ZEUS")](https://intelbras.atlassian.net/jira/software/c/projects/PZ/boards/552). This card have a unique identifier among "Plataforma ZEUS" project, something like "PZ-1234".

Given that a JIRA card is properly created, the following instructions can then be performed.

1. Checkout **`develop branch`**:
    ```
    git checkout develop
    ```

2. Update local **`develop branch`** with any new information from remote repository:
    ```
    git pull
    ```

3. Create a new branch with a **name equal to the JIRA card unique identifier**.

    **ATTENTION:** use correct JIRA card identifier! In the example below it is "**PZ-1234**", it will be different for any other card.
    ```
    git checkout -b PZ-1234
    ```

    If the branch is created with a typo it is possible to delete it:
    ```
    git checkout develop

    git branch -D PZ-123X
    ```
    or rename it:
    ```
    git branch -m PZ-123X PZ-1234
    ```

4. Move the corresponding JIRA card to "**IN PROGRESS**" column and implement your contribution.

5. Add files that you want to commit to the git staging area:
    ```
    git add FILENAME_HERE
    ```

6. Commit your changes to local repository providing a **meaningful** commit message:
    ```
    git commit -m "add your meaningful commit message here"
    ```

7. Push all your commits to a new branch in the remote repository.

    **ATTENTION:** make sure to use the same name that your local working branch has. In the example below it is "**PZ-1234**", it will be different for any other branch.
    ```
    git push --set-upstream origin PZ-1234
    ```

8. Create a **merge request (MR)** in Intelbras GitLab website: [new merge request for Morpheus project](https://git.intelbras.com.br/zeus/morpheus/-/merge_requests/new).

    Source branch **must be** your contribution branch.

    Target branch **must be** develop.

    Merge request title **must** start with the JIRA card unique identifier followed by ':' (*colon punctuation mark*) and a short description.
    ```
    PZ-1234: add Intelbras discovery enable/disable web-e2e tests
    ```

    Merge request description should follow this template:
    ```
    **Reviewers:** @teammate1 @teammate2

    **Closes:** PZ-1234
    ```
    Note that words surrounded by double starts (`**`) will be rendered as **bold** words.

    If you wish to provide some **meaningful** information about your merge request, please do so:
    ```
    **Reviewers:** @teammate1 @teammate2

    **Closes:** PZ-1234

    ---

    Your meaningful merge request information here.
    Your teammates will be grateful for it. :)

    However, if the corresponding JIRA card description is good enough, this usually is not needed. That's why it is not mandatory.
    ```

9. Move the corresponding JIRA card from "**IN PROGRESS**" to "**CODE REVIEW**" column.

    Ask some teammates (usually 2) to review your contribution.

10. Wait until your contribution is properly reviewed.

    A merge request (MR) is considered accepted when it has at least **ONE thumbs up** and all possible discussions are resolved/closed.

11. When a teammate approves your merge request, he/she should move the corresponding JIRA card from **CODE REVIEW** to **MERGE REQUEST** column.

    If your teammates forget to do so, you can move it by yourself, no big deal.

12. Merge your branch with **develop branch** through Intelbras GitLab website: [merge branch](https://git.intelbras.com.br/zeus/morpheus/-/merge_requests).

    The teammate that approved your MR can also merge the branch for you.

    If there are any merge conflicts they should be resolved locally. Merge conflicts are automatically detected by GitLab and the **`merge`** button on the website will not be available.

13. In case of **merge conflicts**:
    
    - Update local **develop branch**:
        ```
        git checkout develop

        git pull
        ```

    - Merge **develop branch** into your banch (**git** will report conflicts):
        ```
        git checkout PZ-1234

        git merge develop
        ```

    - Resolve all conflicts, add modified files to **git** staging area, commit and push changes.
        
        You do not need to provide a commit message here, since a default commit merge message will be shown as soon as you execute "git commit":
        ```
        git add FILENAME_HERE

        git commit

        git push
        ```

        If you wish to abort the merge conflict resolving process for any reason:
        ```
        git merge --abort
        ```

    - After all conflicts are resolved and pushed to the remote repository, go to the Intelbras GitLab website and merge your branch from there.

14. Move the corresponding JIRA card from **MERGE REQUEST** to **CLOSED** column as soon as the merge process is concluded.

    Leave a comment in the corresponding JIRA card:
    ```
    Integrado na develop.
    ```

# Creating test cases

## Test folder structure

Test case files **must be** placed inside [morpheus/tests/](tests/) and **must have** `.robot` file extension.

**`morpheus/tests/`** currently contains one test suite at its highgest level:
- web

Any test that handles DUT through a WEB browser **must be** placed inside this folder.

**`morpheus/tests/web/`** currently contains two test suites at its highest level:
- e2e
- integration

Tests that configure the DUT and also verifies if a feature works in a real environment are considered to be an end-to-end (**e2e**) test. These tests **must be** placed inside **`morpheus/tests/web/e2e/`**.

Tests that configure the DUT but do not check if a feature works in a real environment are considered to be an integration test. These tests **must be** placed inside **`morpheus/tests/web/integration/`**.

## Test file structure

A test file **must have** `.robot` file extension and **must have** a *test cases* section.

It **should have** a *settings* section.

It **may have** a *variables* section.

### Settings section

The **settings** section is identified by `*** Settings ***`.

This section contains a few settings that are related to the test suite.

Common settings are:
- Documentation
- Library
- Resource
- Test Setup
- Test Teardown

**Documentation** is used to define a test suite documentation.

**Library** is used to import a [Robot Framework library](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#importing-libraries).

**Resource** is used to import a [Robot Framework resource file](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-files).

**Test Setup** is used to define a *keyword* that will run **before** every test case execution in the current test suite.

**Test Teardown** is used to define a *keyword* that will run **after** every test case execution in the current test suite.

```
*** Settings ***
Documentation    This test suite contains tests to verify that discovery
...              service settings can be changed and behave according to
...              project requirements and business rules.
Library          Collections
Resource         web/login_pom.resource
Test Setup       Open Browser
Test Teardown    Close Browser
```

### Variables section

The **variables** section is identified by `*** Variables ***`.

This section contains variables that can be used by all tests in the current test suite during test execution.

```
*** Variables ***
${VAR_1}    abcde
${VAR_2}    defgh
${VAR_3}    12345
```

### Test cases section

The **test cases** section is identified by `*** Test Cases ***`.

This section contains all test cases that are related to the test suite.

Test cases **should** start with a capitalized word and all following words **should be** non-capitalized, unless the word represents a brand name or a protocol (in this case it should follow its official representation).

Keywords **should** use **Title Case** (first letter of every word always uppercase), unless the word represents a brand name or a protocol (in this case it should follow its official representation).

```
*** Test Cases ***
Test some NTP feature
    Keyword To Execute A
    Keyword Related To NTP Feature
    Keyword To Execute B
    Keyword To Execute C

Test some Intelbras proprietary feature
    Keyword To Execute X
    Keyword To Enable Intelbras Feature
    Keyword To Execute Y
    Keyword To Execute Z

Test some SNMP feature 
    Keyword To Execute D
    Keyword To Execute E
    Keyword To Execute F
    Keyword Related To SNMP Feature
```

## Example

Suppose we must create an integration test to verify that it is possible to disable Intelbras discovery protocol, save and apply settings.

The steps are roughly the following:
1. open a WEB browser
2. access DUT WEB management page
3. wait for login page to be loaded
4. fill in username and password
5. click login button
6. wait until login is fully performed (management WEB page is opened)
7. access discovery service WEB page
8. unselect Intelbras discovery protocol
9. save and apply settings
10. close WEB browser

This project is using [Robot Framework SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top) to handle the interaction with a WEB browser.

One way to perform DUT login through a WEB browser is shown below (steps 1 to 5):
```
*** Settings ***
Documentation    This test suite contains tests to verify that discovery
...              service settings can be changed and behave according to
...              project requirements and business rules.
Library          SeleniumLibrary

*** Test Cases ***
Disable Intelbras discovery protocol
    Open Browser    url=http://10.0.0.1:80   browser=Chrome
    Wait Until Element Is Visible   usuario
    Input Text    usuario    admin
    Input Text    senha    myPassword123!
    Click Button    logar
    # continue...
```

The first line is the test case name. In this example it is **`Disable Intelbras discovery protocol`**.

Note that a test case **must be** created in `*** Test Cases ***` section.

Following lines are called *keywords* and they **must** start with 4 spaces. Each one of these *keywords* will perform one or multiple actions. All keywords demonstrated so far are already provided by [RF SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top).

Some *keywords* may accept one or more arguments (parameters) and these arguments **must be** 4 spaces apart.

For example, a keyword that clicks a button (WEB element) must be given at least
 one argument that is the *WEB element locator*. Preferably this *locator* should be the [HTML id attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/id).

 ```
 Click Button    logar
 ```

It is also possible to use other [WEB element location strategies](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Locating%20elements): name, CSS class, XPATH, etc.

Even though other location strategies are available, it is always advisable to use the [HTML id attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/id), since it is generally more reliable than any other location strategy.

Going back to the example, DUT login was performed considering that:
- DUT HTTP server was accesible through *`http://10.0.0.1:80`*
- DUT was not in factory default state, since the password was already changed (*`myPassword123!`*)
- Chromedriver is added to **PATH** environment variable

Those steps would not work in a device that is in factory default state because factory default password is not *`myPassword123!`*, either for a development or a production firmware version.

For a production firmware version, these login steps become little more complicated as there are additional steps to perform the first user access password change and terms of use acceptance.

It is also needed to handle the WEB modal that is displayed right after login when Cronos has a firmware version that is newer than the current DUT firmware version.

However, all login steps (including browser opening) are already implemented by a *keyword* which can be found in [morpheus/resources/web/login_pom.resource](resources/web/login_pom.resource):

```
*** Keywords ***
Login To DUT WEB Page Through IPv4 Address
    Access DUT WEB Login Page Through IPv4 Address
    Set Login Username To "${DUT}[env][management][login][username]"
    Set Login Password To "${DUT}[env][management][login][password]"
    Log    DUT current username: ${DUT}[env][management][login][username]
    Log    DUT current password: ${DUT}[env][management][login][password]
    Click Login Button
    ${factory_default}    FiberV3 Check If DUT Is In Factory Default State
    IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}' and ${factory_default} == ${TRUE}
        Wait Until Element Is Visible    ${LOGIN_NEW_PASSWORD_INPUT}
        Perform DUT WEB First Access Password Change
    ELSE
        Wait Until Page Title Is    ${DUT}[profile][general][web_management_page_title]    30s
        Wait For WEB Message To Disappear Or Timeout After "30" Seconds
        Wait Until Status Menu Is Fully Open
    END
    ${cronos_version_is_newer}    Cronos Firmware Version Is Newer Than Current DUT Firmware Version
    IF    ${cronos_version_is_newer} == ${TRUE}
        Reject Cronos Firmware Upgrade Request
    END
```

[Read more about how resource files are implemented in this project.](#creating-test-resources-keywords-and-variables)

Login seemed quite easy at first, huh?

But now, after evaluating all possibilities, there are a lot of checks and actions inside the *keyword* **`Login To DUT WEB Page Through IPv4 Address`**, roughly:
- access DUT WEB management login page (which opens a browser and navigates to DUT WEB management login page)
- fill in username and password (according to settings that are provided in **`morpheus/environment.py`**)
- click login button
- check if DUT is in factory default state and is running a production firmware version
- if DUT is in factory default state and is running a production firmware version than some additional steps must be performed (first user access password change and terms of use acceptance), otherwise just wait until DUT WEB management page is opened
- check if Cronos has a firmware version that is newer than the current DUT firmware version
- if cronos has a newer version then wait for WEB modal to show up and dismiss it

Now that this *keyword* is already implemented it is possible to use it anywhere in the project.
It is needed to import the resource file that contains this *keyword* in order to use it in a test case.
This import is done in `*** Settings ***` section through the [**Resource** setting](#settings-section).

Therefore, it is possible to refactor login steps to a much cleaner version:

```
*** Settings ***
Resource    web/login_pom.resource


*** Test Cases ***
Disable Intelbras discovery protocol
    Login To DUT WEB Page Through IPv4 Address
    # continue...
```

**IMPORTANT**: note that WEB element locators did not appear in the refactored test version, which is a very good aspect in terms of code readability/maintainability. Most of the logic is abstracted by *keywords* that are implemented in [morpheus/resources/](resources/).

So far the following test steps are done (including some extra checks/actions):
1. ~~open a WEB browser~~
2. ~~access DUT WEB management page~~
3. ~~wait for login page to be loaded~~
4. ~~fill in username and password~~
5. ~~click login button~~
6. ~~wait until login is fully performed (management WEB page is opened)~~
7. access discovery service WEB page
8. unselect Intelbras discovery protocol
9. save and apply settings
10. close WEB browser

Now, for step 7, it is needed to perform the following actions:
1. open services menu
2. click discovery submenu
3. wait until discovery WEB page is loaded

All those steps are already implemented by a *keyword* which can be found in [morpheus/resources/web/services/discovery_pom.resource](resources/web/services/discovery_pom.resource):

```
*** Keywords ***
Access Discovery Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${DISCOVERY_SUBMENU}
    Click Element    ${DISCOVERY_SUBMENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${DISCOVERY_INTELBRAS_CHECKBOX}
```

Adding *keyword* **`Access Discovery Service Settings Page`** to the test:

```
*** Test Cases ***
Disable Intelbras discovery protocol
    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    # continue...
```

So far the following test steps are done (including some extra checks/actions):
1. ~~open a WEB browser~~
2. ~~access DUT WEB management page~~
3. ~~wait for login page to be loaded~~
4. ~~fill in username and password~~
5. ~~click login button~~
6. ~~wait until login is fully performed (management WEB page is opened)~~
7. ~~access discovery service WEB page~~
8. unselect Intelbras discovery protocol
9. save and apply settings
10. close WEB browser

Now, for step 8, it is needed to perform the following actions:
1. unselect Intelbras discovery protocol checkbox

This is already implemented by a *keyword* which can be found in [morpheus/resources/web/services/discovery_pom.resource](resources/web/services/discovery_pom.resource):

```
*** Keywords ***
Unselect Intelbras Discovery Protocol Checkbox
    Unselect Checkbox    ${DISCOVERY_INTELBRAS_CHECKBOX}
```

Adding *keyword* **`Unselect Intelbras Discovery Protocol Checkbox`** to the test:

```
*** Test Cases ***
Disable Intelbras discovery protocol
    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    # continue...
```

So far the following test steps are done (including some extra checks/actions):
1. ~~open a WEB browser~~
2. ~~access DUT WEB management page~~
3. ~~wait for login page to be loaded~~
4. ~~fill in username and password~~
5. ~~click login button~~
6. ~~wait until login is fully performed (management WEB page is opened)~~
7. ~~access discovery service WEB page~~
8. ~~unselect Intelbras discovery protocol~~
9. save and apply settings
10. close WEB browser

Now, for step 9, it is needed to perform the following actions:
1. save settings
2. wait until WEB message "Alterações salvas com sucesso" is displayed
3. wait until WEB message disappear
4. apply settings
5. wait until WEB message "Alterações salvas com sucesso" is displayed
6. wait until WEB message disappear

This is already implemented by a *keyword* which can be found in [morpheus/resources/web/common.resource](resources/web/common.resource):

```
*** Keywords ***
Save And Apply Settings
    Save Settings
    Apply Settings
```

Adding *keyword* **`Save And Apply Settings`** to the test:

```
*** Test Cases ***
Disable Intelbras discovery protocol
    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    # continue...
```

So far the following test steps are done (including some extra checks/actions):
1. ~~open a WEB browser~~
2. ~~access DUT WEB management page~~
3. ~~wait for login page to be loaded~~
4. ~~fill in username and password~~
5. ~~click login button~~
6. ~~wait until login is fully performed (management WEB page is opened)~~
7. ~~access discovery service WEB page~~
8. ~~unselect Intelbras discovery protocol~~
9. ~~save and apply settings~~
10. close WEB browser

Now, for the last step (10), it is needed to perform the following actions:
1. close WEB browser

This is already implemented by a RF SeleniumLibrary *keyword*: [Close Browser](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Close%20Browser)

Adding *keyword* [**`Close Browser`**](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Close%20Browser) to the test:

```
*** Test Cases ***
Disable Intelbras discovery protocol
    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    Close Browser
```

All test steps are finished:
1. ~~open a WEB browser~~
2. ~~access DUT WEB management page~~
3. ~~wait for login page to be loaded~~
4. ~~fill in username and password~~
5. ~~click login button~~
6. ~~wait until login is fully performed (management WEB page is opened)~~
7. ~~access discovery service WEB page~~
8. ~~unselect Intelbras discovery protocol~~
9. ~~save and apply settings~~
10. ~~close WEB browser~~

It is a good practice to define which test step is responsible for setup whenever possible.

In this case the test setup is the first step **`Login To DUT WEB Page Through IPv4 Address`**.

Test setup is defined using a **RF** modifier: **`[Setup]`**

```
*** Test Cases ***
Disable Intelbras discovery protocol
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    Close Browser
```

Similarly, test teardown **should be** defined whenever possible.

Test teardown is defined using a **RF** modifier: **`[Teardown]`**

```
*** Test Cases ***
Disable Intelbras discovery protocol
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    [Teardown]    Close Browser
```

**IMPORTANT**: test teardown is rather special because it will be executed regardless of test case execution result, meaning that the *keyword* will be executed even if test case execution fails.

This behavior is very useful in the example provided, because if any keyword fails during test case execution and **`Close Browser`** is not defined as test teardown then a WEB browser instance will be left open.

[Read more about Robot Framework test setup and teardown.](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#test-setup-and-teardown)



# Creating test resources (keywords and variables)

Test resources are a **fundamental** part of this project.

All resource files **must** have **`.resource`** file extension.

Most of the test case logic is implemented in resource files that are located at **`morpheus/resources/`**. This resources folder contains a few other folders in order to keep it organized.

At the highest level, **`morpheus/resources/`** currently contains two folders and one resource file:
- api/
- web/
- utils.resource

Resources that are used to interact with API **must** be implemented by a resource file in **`morpheus/resources/api/`**.

Resources that are used to interact with WEB **must** be implemented by a resource file in **`morpheus/resources/web/`**.

For now, any other type of resource is implemented in **`morpheus/resources/utils.resource`**.

## WEB test resources: page object model design pattern

**Morpheus** follows principles of the [page object model design pattern](https://martinfowler.com/bliki/PageObject.html).

This design pattern is relatively easy to understand and follow, but also quite powerful in terms of code readability and maintainability. It also promotes code reuse as well (*DRY*).

In short:
- all **WEB elements** that you want to handle in a webpage **must** be mapped to a **variable**
- all **actions** that you want to perform in a test **must** be abstracted by a method (**keyword**)

**Good rule of thumb:** a test case **should not** manipulate a WEB element directly. To put it in another way, there **should not** be any HTML IDs, XPATHs, etc. in a test case.

```
*** Test Cases ***
# Bad example:
One bad test case
    Open Browser
    Go To    http://10.0.0.1:80/
    Input Text    usuario    admin
    Input Text    senha    myPassword123!
    Click Button    logar
    Wait Until Element Is Visible    status
    Title Should Be    AP360
    Click Element    services_menu
    Wait Until Element Is Visible    discovery_submenu
    Click Element    discovery_submenu
    # etc...


# Good example:
This is a much better test case
    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    # etc...
```

As an example, suppose that you must create a new test case that interacts with discovery service webpage to check some specific behavior.

The first thing you should do is to check if there is a resource file that already implements what you need. **Morpheus** resource folder structure is organized in a way that it should be easy to find and identify a specific resource.

In this example, some discovery service resources are already implemented in [morpheus/resources/web/services/discovery_pom.resource](resources/web/services/discovery_pom.resource).

If some actions or variables that you need are not implemented, feel free to implement them, that way you are helping to **evolve the project**. In case that a desirable action seems to hard for you to sort out, ask a team member for help.

Keep in mind that there are some [project standards regarding variable naming for WEB elements](#pom-variable-naming-standards).

### POM: variable naming standards

Resource variables **must** be created in `*** Variables ***` section.

```
*** Settings ***
# ...

*** Variables ***
${LOGIN_USERNAME_INPUT}                     usuario
${LOGIN_PASSWORD_INPUT}                     senha
${LOGIN_BUTTON}                             logar
${LOGIN_NEW_PASSWORD_INPUT}                 newPassword
${LOGIN_NEW_PASSWORD_CONFIRMATION_INPUT}    confirmPassword
${LOGIN_CHANGE_PASSWORD_BUTTON}             salvar_button
${LOGIN_COMPLIANCE_CHECKBOX}                compliance_checkbox

*** Keywords ***
# ...
```

Resource variables that represents a WEB element **must** follow guidelines below:

| WEB element       | Variable name MUST end with | Example                                   |
| ---               | ---                         | ---                                       |
| **button**        | **`BUTTON`**                | ${LOGIN_**BUTTON**}                       |
| **checkbox**      | **`CHECKBOX`**              | ${LOGIN_COMPLIANCE_**CHECKBOX**}          |
| **input**         | **`INPUT`**                 | ${LOGIN_USERNAME_**INPUT**}               |
| **select**        | **`SELECT`**                | ${NETWORK_OPMODE_**SELECT**}              |
| select **option** | **`SELECT_<option>_VALUE`** | ${NETWORK_OPMODE_**SELECT_BRIDGE_VALUE**} |
| **table**         | **`TABLE`**                 | ${QOS_SSID_LIMIT_**TABLE**}               |

**IMPORTANT:** there are a few more standards regarding resource variables that represents a WEB element:

- **WEB elements that are a clickable menu (from sidemenu options):** these variables **must** end with **`MENU`**:
    ```
    ${FIREWALL_MENU}
    ```

- **WEB elements that are a clickable submenu (from sidemenu options):** these variables **must** end with **`SUBMENU`**:
    ```
    ${FIREWALL_IP_CONTROL_SUBMENU}
    ```

# Installing new Python/RF libraries

The **`poetry`** tool **must** always be used to add new library to the project.

Run the following command inside **`morpheus/`** to add a new library:
```
poetry add LIBRARY_NAME
```

**ATTENTION:** **DO NOT** use **`pip`** directly, never.

**IMPORTANT:** if your contribution adds a new external library you **must** mention that a new library was added in [merge request description](#contribution-steps-jira-and-gitgitlab-instructions).

It is a good practice to always comunicate to all your teammates that a new library was added to the project, so everyone can update their dependencies.

Run the following command inside **`morpheus/`** to install any missing dependencies when a teammate adds a new library:
```
poetry install
```
